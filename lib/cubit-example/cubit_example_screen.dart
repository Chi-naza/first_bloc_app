import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

const names = [
  'Ifeanyi Ngene',
  'Onyedika',
  'Amara',
  'Adaoma'
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}


// Creating my first cubit
class MyNamesCubit extends Cubit<String?> {
  MyNamesCubit() : super(null);

  void pickRandomNames() => emit(
    names.getRandomElement()
  );
}


class CubitExampleScreen extends StatefulWidget {
  const CubitExampleScreen({super.key});

  @override
  State<CubitExampleScreen> createState() => _CubitExampleScreenState();
}

class _CubitExampleScreenState extends State<CubitExampleScreen> {

  late final MyNamesCubit mycubit;

  @override
  void initState() {
    mycubit = MyNamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    mycubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: mycubit.stream,
          builder: ((context, snapshot) {
            final button = TextButton(
              onPressed: () => mycubit.pickRandomNames(), 
              child: const Text('Pick A Random Name'),
            );
            
            switch(snapshot.connectionState){
              
              case ConnectionState.none:
                return button;
                break;
              case ConnectionState.waiting:
                return button;
                break;
              case ConnectionState.active:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data??''),
                    button
                  ],
                );
                break;
              case ConnectionState.done:
                return SizedBox();
                break;
            }
          }),
        ),
      ),
    );
  }
}