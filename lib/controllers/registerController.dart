import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      print('Name: ${nameController}');
      print('Email: ${emailController.text}');
      print('Senha: ${passwordController.text}');
      print('Confirmar senha: ${confirmPasswordController.text}');
      // chamar api de autenticação
      Navigator.pushNamed(context, '/login');
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

  String? confirmPasswordValidator(password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, confirme sua senha';
    }

    if(password != passwordController.text){
      return 'As senhas não coincidem';
    }
    return null;
  }

}