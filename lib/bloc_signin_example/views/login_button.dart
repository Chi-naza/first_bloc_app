import 'package:first_bloc_app/bloc_signin_example/dialog/generic_dialog.dart';
import 'package:first_bloc_app/bloc_signin_example/strings.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(String email, String password);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;
  
  const LoginButton({super.key, required this.emailController, required this.passwordController, required this.onLoginTapped});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        final email = emailController.text;
        final pswd = passwordController.text;
        // if there is email and pswd
        if(email.isEmpty || pswd.isEmpty){
         showCustomGenericDialog(
          context: context, 
          title: emailAndPswdEmptyTitle, 
          content: emailAndPswdEmptyContent, 
          optionBuilder: () => {'OK': true}
         );
        }else{
          onLoginTapped(email, pswd);
        }
      }, 
      child: Text("Log In")
    );
  }
}