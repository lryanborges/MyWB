import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController sleepController = TextEditingController();

  RxString name = ''.obs;
  RxString weight = ''.obs;
  RxString height = ''.obs;
  RxString sleep = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final isEditing = false.obs;
  final selectedPersona = ''.obs;
  final selectedObjective = ''.obs;
  var firstUse = true;
  Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users')
          .doc(user.uid)
          .get();

        if(userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          nameController.text = userData['nome'] ?? '';
          weightController.text = userData['peso'] ?? '';
          heightController.text = userData['altura'] ?? '';
          sleepController.text = userData['sono'] ?? '';
          selectedPersona.value = userData['wb_persona'];
          selectedObjective.value = userData['user_objective'];
          firstUse = userData['first_use'];

          name.value = nameController.text;
          weight.value = weightController.text;
          height.value = heightController.text;
          sleep.value = sleepController.text;

          String? profilePicUrl = userData['profile_pic_url'];
          if(profilePicUrl != null && profilePicUrl.isNotEmpty) {
            selectedImage.value = await _baixarImagem(profilePicUrl);
          }
        }
        else {
          return;
        }
      }
    }
    catch(e) {
      Get.snackbar("Erro", "Erro ao carregar dados: $e");
    }
  }

  Future<void> saveDatas() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        String uid = user.uid;

        String? profilePicUrl;
        if(selectedImage.value != null) {
          profilePicUrl = await _storage.ref()
            .child('images/$uid/profile_pic')
            .getDownloadURL();
        }

        Map<String, dynamic> userData = {
          'nome': nameController.text,
          'peso': weightController.text,
          'altura': heightController.text,
          'sono': sleepController.text,
          'wb_persona': selectedPersona.value,
          'user_objective': selectedObjective.value,
          'profile_pic_url': profilePicUrl,
          'first_use': false
        };

        await _firestore.collection('users')
          .doc(uid)
          .set(userData, SetOptions(merge: true));

        name.value = nameController.text;
        weight.value = weightController.text;
        height.value = heightController.text;
        sleep.value = sleepController.text;

        Get.snackbar('Sucesso:', 'Dados salvos com sucesso!');

        if(firstUse) {
          firstUse = false;
          Future.delayed(const Duration(seconds: 1), () => Get.toNamed("/home"));
        }
        else {
          Get.toNamed("/profile");
        }
      }
    }
    catch(e) {
      Get.snackbar('Error:', 'Não foi possível salvar os dados: $e');
    }
  }

  Future<void> selecionarImagem() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      XFile? compressedImage = await compressImage(imageFile);

      if(compressedImage != null) {
        selectedImage.value = File(compressedImage.path);
        await uploadImagem();
      }
    }
  }

  Future<void> uploadImagem() async {
    try {
      User? user = _auth.currentUser;

      if (user != null && selectedImage.value != null) {
        String uid = user.uid;

        // Caminho de armazenamento no Firebase Storage
        Reference storageRef = _storage.ref().child("images/$uid/profile_pic");

        // Upload da imagem
        UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Obter URL da imagem
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Atualiza o Firestore com o URL da imagem
        await _firestore.collection("users").doc(uid).update({
          "profile_pic_url": downloadURL,
        });

        //Get.snackbar("Sucesso", "Imagem de perfil atualizada!");
      } else {
        Get.snackbar("Erro", "Selecione uma imagem para continuar");
      }
    } catch (e) {
      //Get.snackbar("Erro", "Erro ao fazer upload da imagem: $e");
    }
  }

  Future<XFile?> compressImage(File imageFile) async {
    // Defina o caminho para salvar a imagem comprimida
    final directory = await getTemporaryDirectory();
    final targetPath = '${directory.path}/compressed_${imageFile.path.split('/').last}';

    // Comprime a imagem
    var result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,  // Caminho original da imagem
      targetPath,               // Caminho onde será salva a imagem comprimida
      quality: 40,              // Qualidade da compressão (0 a 100)
    );

    return result; // Retorna a imagem comprimida
  }

  Future<File?> _baixarImagem(String url) async {
    try {
      // Usar o pacote http ou dio para baixar a imagem
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Salvar a imagem em um arquivo local
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/foto_perfil.png';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return file; // Retornar o arquivo baixado
      }
    } catch (e) {
      Get.snackbar("Erro", "Erro ao baixar imagem: $e");
    }
    return null;
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }
}