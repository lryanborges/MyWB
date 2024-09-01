import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/controllers/chatController.dart';

class MessageList extends StatelessWidget {
  final ChatController controller;

  const MessageList({
    super.key, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.messages[index]),
        );
      },
    ));
  }
}