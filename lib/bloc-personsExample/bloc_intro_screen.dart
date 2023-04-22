import 'dart:convert';
import 'dart:io';
import 'package:first_bloc_app/bloc-personsExample/bloc_actions.dart';
import 'package:first_bloc_app/bloc-personsExample/person.dart';
import 'package:first_bloc_app/bloc-personsExample/persons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

class BlocIntroScreen extends StatefulWidget {
  const BlocIntroScreen({super.key});

  @override
  State<BlocIntroScreen> createState() => _BlocIntroScreenState();
}

class _BlocIntroScreenState extends State<BlocIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOAD JSON FROM LOCAL SERVER'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: (){
                  // Loading the bloc action
                  context.read<PersonsBloc>().add(LoadPersonAction(url: personUrl1, loader: getPersons));
                }, 
                child: const Text('Load JSON Number 1'),
              ),
              TextButton(
                onPressed: (){
                  // Loading the bloc action
                  context.read<PersonsBloc>().add(LoadPersonAction(url: personUrl2, loader: getPersons));
                }, 
                child: const Text('Load JSON Number 2'),
              ),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResult?>(
            buildWhen: (previous, current) {
              return previous?.persons != current?.persons;
            },
            builder: (context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;

              if(persons == null){
                return const SizedBox();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index];
                    return ListTile(
                      title: Text(person!.name),
                      subtitle: Text(person.age.toString()),
                    );
                  },
                ),
              );
              
            },
          ),     
        ],
      ),
    );
  }
}





















// A function which simulates data fetch. Simulation achieved with vs code live server.
Future<Iterable<Person>> getPersons(String url) async{
  return await HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((resp) => resp.transform(utf8.decoder).join())
  .then((str) => json.decode(str) as List<dynamic>)
  .then((list) => list.map((e) => Person.fromJson(e)));
}








// An extension to extend the functionalities of an Iterable, especially for our list
// If the element of the iterable accessed is not available, then, return null, instead of error
extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}



/// Adding Logging to our application
extension Log on Object {
  void log() => devtools.log(toString());
}