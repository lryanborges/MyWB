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
            final message = controller.messages[index];
            final bool isUser = message['sender'] == 'user';

            return Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isUser) ...[
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVLDPl6fLluSt7-NAU8GGKeTnhbIDqirzmTA&s',
                      ),
                    ),
                    const SizedBox(width: 0), // Espaçamento entre avatar e mensagem
                  ],
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? tdContrastBlue : tdMessageContainer, // Cor diferente para mensagens do bot
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      message['text'],
                      style: const TextStyle(color: tdFontColor),
                    ),
                  ),
                  if (isUser) ...[
                    const SizedBox(width: 0),
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRurO8kRj216kjoFZVmlyf2v2eak-uUfukQKQ&s',
                            ) as ImageProvider,
                    ),
                  ],
                ],
              ),
            );
          },
        ));
  }
}
