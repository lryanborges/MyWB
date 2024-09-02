import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/pages/init.dart';
import 'package:my_wb/pages/chat.dart';
import 'package:my_wb/pages/login.dart';
import 'package:my_wb/pages/profile.dart';
import 'package:my_wb/pages/register.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/home', page: () => Init()),
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register())
      ],
      title: 'My Welly Beingjamin',
      theme: ThemeData(
        fontFamily: 'Poppins',

      ),
      debugShowCheckedModeBanner: false,
    )
  );
}