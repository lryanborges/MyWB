import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final List<String> messages = <String>[].obs;
  final messageController = TextEditingController();

  void sendMessage(String message) {
    if(message.isNotEmpty) {
      messages.add(message);
    }
  }
}