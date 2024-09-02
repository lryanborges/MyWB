import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/myNavController.dart';

class BottomNavBar extends StatelessWidget {
  final controller = Get.put(MyNavController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tdDarkerColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              color: controller.currentIndex.value == 0 
                  ? tdSelected 
                  : tdWhite,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: tdAccentColor,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
              ),
            ), 
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/configs.svg',
              width: 24,
              height: 24,
              color: controller.currentIndex.value == 2 
                  ? tdSelected 
                  : tdWhite,
            ),
            onPressed: () {
              // Adicionar rota depois
            },
          ),
        ],
      ),
    );
  }
}
