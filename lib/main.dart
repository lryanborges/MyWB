import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/pages/init.dart';
import 'package:my_wb/pages/chat.dart';
import 'package:my_wb/pages/profile.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => Init()),
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/profile', page: () => Profile())
      ]
    )
  );
}