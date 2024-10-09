import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final isEditing = false.obs;
  final selectedPersona = ''.obs;
  final selectedObjective = ''.obs;

  TextEditingController nameController = TextEditingController();

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }
}