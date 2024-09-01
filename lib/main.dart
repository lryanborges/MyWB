import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/pages/init.dart';
import 'package:my_wb/pages/chat.dart';
import 'package:my_wb/pages/profile.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/profile',
      getPages: [
        //GetPage(name: '/home', page: () => Init()),
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/profile', page: () => Profile())
      ]
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Welly Beingjamin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        textTheme: const TextTheme(
          bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          ),
        ),

      ),
      home: const Init(name: 'Ryan'),
      debugShowCheckedModeBanner: false,
    );
  }
}