import 'package:first_bloc_app/Firebase%20Error%20Handler/auth_errors.dart';
import 'package:first_bloc_app/bloc_signin_example/dialog/generic_dialog.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<void> showAuthErrorDialog({required BuildContext context, required AuthError authError}){
  return showCustomGenericDialog<bool>(
    context: context, 
    title: authError.dialogTitle, 
    content: authError.dialogContent, 
    optionBuilder: () => {'OK': true}
  );
}