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
        title: Text('Falando com Welly Beingjamin', style: TextStyle(color: tdWhite, fontSize: 18)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: tdWhite,),
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
            padding: EdgeInsets.all(30.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
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
                      controller: controller.messageController,
                      style: TextStyle(color: tdFontColor),
                      decoration: InputDecoration(
                        hintText: 'Escreva para o WB',
                        hintStyle: TextStyle(color: tdFontColor.withOpacity(0.2)),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: () {
                      controller.sendMessage(controller.messageController.text);
                      controller.messageController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                      backgroundColor: tdButton
                    ),
                    child: Icon(Icons.send, color: tdWhite, size: 20,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}