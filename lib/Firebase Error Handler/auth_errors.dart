import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authErrorMapping = {
  "user-not-found": AuthErrorUserNotFound(),
  "weak-password": AuthErrorWeakPassword(),
  "invalid-email": AuthErrorInvalidEmail(),
  "operation-not-allowed": AuthErrorOperationNotAllowed(),
  "email-already-in-use": AuthErrorEmailAlreadyInUse(),
  "requires-recent-login": AuthErrorRequiresRecentLogin(),
  "no-current-user": AuthErrorNoCurrentUser(),
  "wrong-password": AuthErrorWrongPassword(),
  "user-disabled": AuthErrorUserDisabled()
};



@immutable abstract class AuthError {
  final String dialogTitle;
  final String dialogContent;

  const AuthError({required this.dialogTitle, required this.dialogContent});

  factory AuthError.from(FirebaseAuthException exception){
    return authErrorMapping[exception.code.toLowerCase().trim()] ?? const AuthErrorUnknown();
  }  
}


@immutable class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown() : super(dialogTitle: 'Authentication Error', dialogContent: 'Unknown authentication error');
}



@immutable class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin() : super(dialogTitle: 'Requires Recent Login', dialogContent: 'You need to login again in order to perform this operation');
}



@immutable class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser() : super(dialogTitle: 'No Current User', dialogContent: 'No current user with this information was found!');
}



@immutable class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed() : super(dialogTitle: 'Operation Not Allowed', dialogContent: 'You cannot perform this operation at this moment in time.');
}



@immutable class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound() : super(dialogTitle: 'User Not Found', dialogContent: 'The given user was not found on the server');
}


@immutable class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail() : super(dialogTitle: 'Invalid Email', dialogContent: 'Please check your email again and try once more!');
}


@immutable class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse() : super(dialogTitle: 'Email Already In Use', dialogContent: 'Please choose another email to register with');
}



@immutable class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword() : super(dialogTitle: 'Weak Password', dialogContent: 'Please choose a stronger password with more characters and symbols');
}


@immutable class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword() : super(dialogTitle: 'Wrong Password', dialogContent: 'You have provided a wrong password to this account. Check again!');
}


@immutable class AuthErrorUserDisabled extends AuthError {
  const AuthErrorUserDisabled() : super(dialogTitle: 'User Disabled', dialogContent: 'The account of this user is disabled at the moment!');
}