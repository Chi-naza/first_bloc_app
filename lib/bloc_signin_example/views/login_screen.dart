import 'package:first_bloc_app/bloc_signin_example/views/email_text_field.dart';
import 'package:first_bloc_app/bloc_signin_example/views/login_button.dart';
import 'package:first_bloc_app/bloc_signin_example/views/pswd_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookWidget {
  final OnLoginTapped onLoginTapped;
  
  const LoginScreen({ required this.onLoginTapped, super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final pswdController = useTextEditingController();    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextWidget(emailController: emailController),
          PasswordTextField(passwordController: pswdController),
          LoginButton(emailController: emailController, passwordController: pswdController, onLoginTapped: onLoginTapped),
        ],
      ),
    );
  }
}