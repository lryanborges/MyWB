import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/chat_controller.dart';
import 'package:my_wb/widgets/message_list.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    
    return Scaffold(
      backgroundColor: tdBG,
      appBar: AppBar(
        title: const Text(
          'Falando com Welly Beingjamin', 
          style: TextStyle(
            color: tdWhite, 
            fontSize: 18
          )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: tdWhite,),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: tdBG,
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(controller: controller),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: tdDarkerColor,
                border: Border.all(
                  color: tdWhite.withOpacity(0.2),
                  width: 1
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messagesController,
                      style: const TextStyle(color: tdFontColor),
                      decoration: InputDecoration(
                        hintText: 'Escreva para o WB',
                        hintStyle: TextStyle(color: tdFontColor.withOpacity(0.2)),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Obx(() {
                    // Observa a variável currentMessage
                    return GestureDetector(
                      onLongPressStart: (_) {
                        if (controller.currentMsg.value.isEmpty) {
                          controller.startListening();
                        }
                      },
                      onLongPressEnd: (_) {
                        controller.stopListening();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.currentMsg.value.isNotEmpty) {
                            controller.sendMessage(controller.messagesController.text);
                            controller.messagesController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: tdButton
                        ),
                        child: Icon(
                          controller.currentMsg.value.isEmpty
                              ? Icons.mic
                              : Icons.send,
                          color: tdWhite, 
                          size: 20,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}