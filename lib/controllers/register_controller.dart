import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleRegister() async {
    if (formKey.currentState!.validate()) {
      try {
          await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.snackbar("Sucesso", "Você foi registrado com sucesso!");
        Future.delayed(const Duration(seconds: 1), () => Get.toNamed("/profile_details"));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar("Conta já existe", "A conta informada já existe!");
        }
      }
    }
  }

  String? validatePassword(String? password) {
    if (GetUtils.isLengthLessThan(password, 8)) {
      return "A senha deve conter no mínimo 8 caracteres!";
    }
    return null;
  }

  String? validadeConfirmPwd(String? confirmPwd) {
    if (confirmPwd != passwordController.text) {
      return "O campo deve ter o mesmo valor do campo 'Senha'";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? "")) {
      return "O email fornecido é inválido";
    }
    return null;
  }
}