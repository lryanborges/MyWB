import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/chat_controller.dart';

class MessageList extends StatelessWidget {
  final ChatController controller;

  const MessageList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            return Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: tdMessageContainer,
                        borderRadius: BorderRadius.circular(15)),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    child: Text(
                      controller.messages[index],
                      style: const TextStyle(color: tdFontColor),
                    ),
                  ),
                  const SizedBox(width: 0,),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: controller.selectedImage.value != null
                        ? FileImage(controller.selectedImage.value!)
                        : const NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRurO8kRj216kjoFZVmlyf2v2eak-uUfukQKQ&s'
                        ) as ImageProvider,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
