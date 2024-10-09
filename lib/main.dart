import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wb/firebase_options.dart';
import 'package:my_wb/routes/app_pages.dart';
import 'package:my_wb/service/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  Get.put(FirebaseService());
  runApp(const MyWBApp());
}

class MyWBApp extends StatelessWidget {
  const MyWBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      title: 'MyWB',
      initialRoute: Routes.profile,
      getPages: AppPages().pages,
    );
  }
}