import 'package:first_bloc_app/bloc_signin_example/bloc/actions.dart';
import 'package:first_bloc_app/bloc_signin_example/bloc/app_bloc.dart';
import 'package:first_bloc_app/bloc_signin_example/bloc/app_state.dart';
import 'package:first_bloc_app/bloc_signin_example/dialog/generic_dialog.dart';
import 'package:first_bloc_app/bloc_signin_example/dialog/loading_screen.dart';
import 'package:first_bloc_app/bloc_signin_example/login_api.dart';
import 'package:first_bloc_app/bloc_signin_example/models.dart';
import 'package:first_bloc_app/bloc_signin_example/notes_api.dart';
import 'package:first_bloc_app/bloc_signin_example/strings.dart';
import 'package:first_bloc_app/bloc_signin_example/views/iterable_list_of_notes.dart';
import 'package:first_bloc_app/bloc_signin_example/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
    
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.red,
  //     ),
  //     home: BlocProvider(
  //       create: (context) => PersonsBloc(),
  //       child: SignInBlocExample(),
  //     ),
  //   );
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Pseudo Bloc Auth Example')),
        body: BlocProvider(
          create: (context) => AppBloc(loginAPI: LoginApi(), notesAPI: NotesApi()),
          child: BlocConsumer<AppBloc, AppStates>(
            listener: (context, state) {
              if(state.isLoading){
                // show loading screen
                LoadingScreen.instance().show(text: "Please wait . . .", context: context);
              }else{
                LoadingScreen.instance().hide();
              }
              // Show Possible Errors
              final loginError = state.loginError;
              if(loginError != null){
                showCustomGenericDialog<bool>(
                  context: context, 
                  title: loginErrorTitle, 
                  content: loginErrorContent, 
                  optionBuilder: () => {'OK': true}
                );
              }
              // If we are logged In and there are no NOTES, fetch them !
              if(state.isLoading == false && state.loginError == null && state.fetchedNotes == null && state.loginHandler == const LoginHandler.loginMagic()){
                // reading or consuming the results (Notes)
                context.read<AppBloc>().add(LoadNotesActions());
              }
            },
            builder: (context, state) {
              final notes = state.fetchedNotes;
              if(notes == null){
                return LoginScreen(onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(LoginAction(email: email, password: password));
                });
              }else{
                return notes.toListView();  // calling an extension
              }
            }, 
          ),
        ),
      ),
    );
  }
  
}

