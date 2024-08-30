import 'package:flutter/material.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/widgets/my_nav_bar.dart';

class Init extends StatefulWidget {
  final String name;

  const Init({Key? key, required this.name}) : super(key: key);

  @override
  State<Init> createState() => _InitialPageState();
}

class _InitialPageState extends State<Init> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    print('Selected Index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:  Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyNavBar(
        currentIndex: _currentIndex, // Atualiza o índice atual
        onTap: _onItemTapped, // Passa a função de callback
      ),
    );
  }
}
