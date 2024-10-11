import 'dart:io';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

part '../constants/keys.dart';

class ChatController extends GetxController {
  final List<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final messageController = TextEditingController();
  final RxString currentMsg = ''.obs;

  String weight = '';
  String height = '';
  String sleep = '';
  String persona = '';
  String objective = '';
  bool firstChat = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<File?> selectedImage = Rx<File?>(null);

  late stt.SpeechToText _speech;
  RxBool isListening = false.obs;
  RxString recognizedText = ''.obs;

  final String apiKey = Keys.cohereKey;

  @override
  void onInit() {
    super.onInit();
    firstChat = true;
    messageController.addListener(() {
      currentMsg.value = messageController.text;
    });
    _speech = stt.SpeechToText();
    _loadData();
  }

  Future<void> sendMessage(String message) async {
    if(message.isNotEmpty) {
      messages.add({"text": message, "sender": "user"});

      if(firstChat) {
        final msg = 'Considere as informações, porém não as comente durante a conversa elas são apenas dados para que utilize. Apenas responda mensagens relacionadas a saúde e seja SUCINTO nas respostas. Peso: $weight; Altura: $height; Sono: $sleep.Adote uma personalidade $persona e meu objetivo é de $objective.A partir daqui será onde você deverá começar a responder. $message';
        firstChat = false;

        final response = await _getBotResponse(msg);
        if(response != null) {
          messages.add({"text": response, "sender": "bot"});
        }
        else {
          Get.snackbar("Erro", "Erro ao obter resposta do bot");
        }
      }
      else {
        final response = await _getBotResponse(message);
        if(response != null) {
          messages.add({"text": response, "sender": "bot"});
        }
        else {
          Get.snackbar("Erro", "Erro ao obter resposta do bot");
        }
      }
    }
  }

  Future<String?> _getBotResponse(String userInput) async {
    const url = 'https://api.cohere.com/v2/chat'; // URL da API da Cohere

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'model': 'command-r', // Defina o modelo que deseja usar
          'messages': [
            {
              'role':'user',
              'content': userInput
            }
          ],
          'stream':false
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes); // Decodificando a resposta
        final data = jsonDecode(responseBody);
        return data['message']['content'][0]['text'].trim(); // Resposta gerada pela Cohere
      } else {
        print('Erro na API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao chamar a API: $e');
      return null;
    }
  }

  Future<void> startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val')
    );

    if(available) {
      isListening.value = true;
      _speech.listen(
        onResult: (val) {
          recognizedText.value = val.recognizedWords;
          messageController.text = recognizedText.value;
        }
      );
    }
  }

  void stopListening() {
    _speech.stop();
    isListening.value = false;
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

          weight = userData['peso'] ?? '';
          height = userData['altura'] ?? '';
          sleep = userData['sono'] ?? '';
          persona = userData['wb_persona'];
          objective = userData['user_objective'];

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