import 'package:get/get.dart';

class MyNavController extends GetxController {
  var currentIndex = 10.obs;

  void onTap(int index) {
    currentIndex.value = index;
  }
}