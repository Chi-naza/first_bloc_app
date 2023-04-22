import 'package:first_bloc_app/Hooks_Tutorial/string_example.dart';
import 'package:first_bloc_app/bloc-personsExample/bloc_intro_screen.dart';
import 'package:first_bloc_app/bloc-personsExample/persons_bloc.dart';
import 'package:first_bloc_app/cubit-example/cubit_example_screen.dart';
import 'package:flutter/material.dart';
import'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PersonsBloc(),
        child: StringExampleHooks(),
      ),
    );
  }
}

