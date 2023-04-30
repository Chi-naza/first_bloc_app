import 'package:first_bloc_app/bloc_signin_example/strings.dart' show enterYourEmailHere;
import 'package:flutter/material.dart';

class EmailTextWidget extends StatelessWidget {
  final TextEditingController emailController;
  
  const EmailTextWidget({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: const InputDecoration(
        hintText: enterYourEmailHere,
      ),
    );
  }
}