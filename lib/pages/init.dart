import 'package:flutter/material.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/widgets/bottomNavBar.dart';

class Init extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      appBar: AppBar(
        title: Text('Menu', style: TextStyle(fontSize: 18, color: tdFontColor),),
        centerTitle: true,
        backgroundColor: tdBG,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Olá User069! Que bom que está aqui!', style: TextStyle(fontSize: 18, color: tdFontColor),),
            SizedBox(height: 30.0,),
            Image.asset('assets/images/hi-robot.png'),
            SizedBox(height: 30.0,),
            Text('Vamos conversar?', style: TextStyle(fontSize: 18, color: tdFontColor),),
            SizedBox(height: 60.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}