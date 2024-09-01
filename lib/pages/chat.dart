import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/chatController.dart';
import 'package:my_wb/widgets/messageList.dart';

class Chat extends StatelessWidget {
  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: tdDarkerColor,
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
                        hintStyle: TextStyle(color: tdFontColor.withOpacity(0.4)),
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
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: TextField(controller: controller.messageController,),
              trailing: ElevatedButton(
                onPressed: () {
                  controller.sendMessage(controller.messageController.text);
                  controller.messageController.clear();
                },
                child: Text('Enviar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}