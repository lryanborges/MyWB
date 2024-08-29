import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Init extends StatefulWidget {
  final String name;

  const Init({required this.name});

  @override
  State<Init> createState() => _InitialPageState();

}

class _InitialPageState extends State<Init> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        iconSize: 30,
        selectedFontSize: 20,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Test", backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_outlined), label: "Test2", backgroundColor: Colors.yellow),
        ],
      ),
    );
  }

}