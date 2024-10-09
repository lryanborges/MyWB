import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/mynav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyNavController());
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: tdDarkerColor,
          //padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child:Container(
                  color: controller.currentIndex.value == 0 ? tdSelected : tdDarkerColor,
                  //padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      width: 24,
                      height: 24,
                      color: tdWhite,
                    ),
                    onPressed: () {
                      controller.onTap(0);
                      Get.toNamed('/profile');
                    },
                  ),
                ),
              ),

              const SizedBox(width: 100),

              Expanded(
                child: Container(
                  color: controller.currentIndex.value == 2 ? tdSelected : tdDarkerColor,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/configs.svg',
                      width: 32,
                      height: 32,
                      color: controller.currentIndex.value == 2
                          ? tdSelected
                          : tdWhite,
                    ),
                    onPressed: () {
                      // Adicionar rota depois
                      controller.onTap(2);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 20,
          right: (MediaQuery.of(context).size.width/2) - 40,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: tdAccentColor,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/chat.svg',
                width: 42,
                height: 42,
              ),
              onPressed: () {
                controller.onTap(1);
                Get.toNamed('/chat');
              },
            ),
          ),
        ),
      ],
    );
  }
}
