import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        );

        Get.snackbar('Sucesso:', 'Você foi logado!');
        Future.delayed(
          const Duration(seconds: 1),
          () => Get.toNamed('/home')
        );
      }
      on FirebaseAuthException catch(e) {
        if(e.code == 'user-not-found') {
          Get.snackbar('Usuário não encontrado:', 'Não existe nenhum usuário com as credenciais informadas!');
        }
        else if(e.code == 'wrong-password') {
          Get.snackbar("Senha errada", "A senha informada está incorreta!");
        }
        else if(e.code == 'invalid-credential') {
          Get.snackbar('Credenciais Inválidas:', 'Usuário não cadastrado!');
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

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? "")) {
      return "O email fornecido é inválido";
    }
    return null;
  }
}