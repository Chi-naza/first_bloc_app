import 'package:first_bloc_app/bloc_signin_example/strings.dart' show enterYourPasswordHere;
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  
  const PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere
      ),

    );
  }
}