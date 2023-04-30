
import 'package:first_bloc_app/bloc_signin_example/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandler?> login({required String email, required String password});
}




@immutable class LoginApi implements LoginApiProtocol {
  // Implementing the function from the abstract class
  @override
  Future<LoginHandler?> login({required String email, required String password}) {
       return Future.delayed(const Duration(seconds: 3), ()=> email=="chinaza@gmail.com" && password=="123456789").then((isLoggedIn){
      return isLoggedIn? LoginHandler.loginMagic() : null;
    });
  }

}