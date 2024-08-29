import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Init extends StatefulWidget {
  final String name;

  const Init({Key? key, required this.name}): super(key: key);

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
      body: const Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal
                )
            )
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        iconSize: 30,
        selectedFontSize: 20,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_outlined), label: "Test2", backgroundColor: Colors.yellow),
        ],
      ),
    );
  }

}