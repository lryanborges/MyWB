
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/controllers/registerController.dart';

import '../constants/colors.dart';

class Register extends StatelessWidget {
  final controller = Get.put(RegisterController());

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
                    key: controller.formKey,
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
                            controller: controller.emailController,
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
                            validator: (email) => controller.validateEmail(email),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: controller.passwordController,
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
                            validator: (senha) => controller.validatePassword(senha),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: controller.confirmPasswordController,
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
                            validator: (senha) => controller.validadeConfirmPwd(senha),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () => controller.handleRegister(),
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