import 'package:flutter/foundation.dart' show immutable;

@immutable class LoginHandler {
  final String token;

  const LoginHandler({required this.token});

  const LoginHandler.loginMagic(): token = "login-magic-123456789";

  @override
  bool operator == (covariant LoginHandler other) => token == other.token;
  
  @override
  int get hashCode => token.hashCode;

  @override
  String toString() {
    return "Login Handle (Token = $token)";
  }
  

}



enum LoginErrors {
  invalidHandle
}


@immutable class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() {
    // TODO: implement toString
    return "This is Note :::: Title = $title";
  }
}


// Notes to be generated when user successfully logs in
final mockNotes = Iterable.generate(5, (i){
  return Note(title: "Note ${i + 1}");
});