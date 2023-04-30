import 'package:first_bloc_app/bloc_signin_example/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable class AppStates {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandler? loginHandler;
  final Iterable<Note>? fetchedNotes;

  const AppStates({required this.isLoading, this.loginError, this.loginHandler, this.fetchedNotes});

  const AppStates.empty(): 
    isLoading = false,
    loginError = null,
    loginHandler = null,
    fetchedNotes = null;
    

  @override
  String toString() => {
    "isLoading": isLoading,
    "loginError": loginError,
    "loginHandler": loginHandler,
    "Notes": fetchedNotes,
  }.toString();
}