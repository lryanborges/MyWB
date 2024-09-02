
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController}');
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
      print('Confirmar senha: ${_confirmPasswordController.text}');
      // chamar api de autenticação
      Navigator.pushNamed(context, '/login');
    }
  }

  String? _emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Insira um e-mail válido';
    }

    return null;
  }

  String? _passwordValidator(password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    return null;
  }

  String? _confirmPasswordValidator(password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, confirme sua senha';
    }

    if(password != _passwordController.text){
      return 'As senhas não coincidem';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      body: SingleChildScrollView (
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/robot-giving-heart.png'),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: tdFontColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'type your name',
                              filled: true,
                              fillColor: tdWhite,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: tdContainer,
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: SvgPicture.asset('assets/icons/name.svg', width: 32.0, height: 32.0,),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'type your address e-mail',
                              filled: true,
                              fillColor: tdWhite,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: tdContainer,
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: SvgPicture.asset('assets/icons/email.svg', width: 32.0, height: 32.0,),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: _emailValidator,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'type your password',
                              filled: true,
                              fillColor: tdWhite,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: tdContainer,
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: SvgPicture.asset('assets/icons/lock.svg', width: 32.0, height: 32.0),
                                ),
                              ),
                            ),
                            obscureText: true,
                            validator: _passwordValidator,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: 'type your password again',
                              filled: true,
                              fillColor: tdWhite,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: tdContainer,
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: SvgPicture.asset('assets/icons/confirm.svg', width: 32.0, height: 32.0),
                                ),
                              ),
                            ),
                            obscureText: true,
                            validator: _confirmPasswordValidator,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () => _register(context),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(tdContrastBlue),
                                foregroundColor: MaterialStateProperty.all(tdFontColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    )
                ),
                const SizedBox(height: 35.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already registered? ',
                        style: TextStyle(
                          color: tdFontColor,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: tdContrastBlue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
  
}