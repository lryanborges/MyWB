import 'package:flutter/material.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyNavBar({Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      backgroundColor: tdDarkerColor,
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg', // Caminho para o arquivo SVG
              width: 30,
              height: 30,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Transform(
              transform: Matrix4.translationValues(0, -40, 0),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: tdAccentColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/chat.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/configs.svg',
              width: 30,
              height: 30,
            ),
            label: '')
      ],
      selectedItemColor: tdSelected,
      unselectedItemColor: tdDarkerColor,
    );
  }
}
