import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final List<String> messages = <String>[].obs;
  final messageController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadImage();
  }

  void sendMessage(String message) {
    if(message.isNotEmpty) {
      messages.add(message);
    }
  }

  Future<void> _loadImage() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users')
          .doc(user.uid)
          .get();

        if(userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          String? profilePicUrl = userData['profile_pic_url'];
          if(profilePicUrl != null && profilePicUrl.isNotEmpty) {
            selectedImage.value = await _baixarImagem(profilePicUrl);
          }
        }
      }
    }
    catch(e) {
      Get.snackbar("Erro", "Erro ao carregar dados: $e");
    }
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
}