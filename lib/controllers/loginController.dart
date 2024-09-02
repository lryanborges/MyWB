import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      print('Email: ${emailController.text}');
      print('Senha: ${passwordController.text}');
      // chamar api de autenticação
      Navigator.pushNamed(context, '/home');
    }
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Insira um e-mail válido';
    }

    return null;
  }

  String? passwordValidator(password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    return null;
  }
}