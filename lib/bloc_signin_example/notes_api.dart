
import 'package:first_bloc_app/bloc_signin_example/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable abstract class NotesAPIprotocol {
  const NotesAPIprotocol();

  Future<Iterable<Note>?> getNotes({required LoginHandler loginHandler});
}



@immutable class NotesApi implements NotesAPIprotocol {
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandler loginHandler}) {
    return Future.delayed(const Duration(seconds: 3), () => loginHandler == const LoginHandler.loginMagic()? mockNotes : null);
  }

}