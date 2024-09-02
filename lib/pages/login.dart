
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_wb/pages/profile.dart';

import '../constants/colors.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
      // chamar api de autenticação
      Navigator.pushNamed(context, '/home');
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
                Image.asset('assets/images/very-happy-robot.png'),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: tdFontColor,
                            ),
                          ),
                          const SizedBox(height: 20),

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
                          const SizedBox(height: 24.0),
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
                          const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: tdFontColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: tdFontColor,
                                      decorationThickness: 2.0
                                  )
                              ),
                          ),
                          const SizedBox(height: 32.0),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child:ElevatedButton(
                              onPressed: () => _login(context),
                              child: Text(
                                'Login',
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
                const SizedBox(height: 110.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Not registered? ',
                        style: TextStyle(
                          color: tdFontColor,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register Now',
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