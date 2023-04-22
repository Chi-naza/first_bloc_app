

import 'package:bloc_test/bloc_test.dart';
import 'package:first_bloc_app/bloc-personsExample/bloc_actions.dart';
import 'package:first_bloc_app/bloc-personsExample/person.dart';
import 'package:first_bloc_app/bloc-personsExample/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

const mockedPersons1 = [
  Person(name: 'Chinaza', age: 24),
  Person(name: 'Emeka', age: 12)
];

const mockedPersons2 = [
  Person(name: 'Chinaza', age: 24),
  Person(name: 'Emeka', age: 12)
];


// Creating mocked functions for the two mocked iterables above
Future<Iterable<Person>> mockGetPersons1(String _) =>
  Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
  Future.value(mockedPersons2);



// The entry point of our test
void main() {
  group("Testing Bloc", (){
    // write our tests here
    late PersonsBloc bloc;

    // This is called before each function is run
    setUp((){
      bloc = PersonsBloc();
    });

    // Testing for our initial state
    blocTest<PersonsBloc, FetchResult?>(
      "Test Initial State", 
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    // Test: Fetch mock data (Persons1) and compare it with mock result
    blocTest<PersonsBloc, FetchResult?>(
      "Mock Retrieving Persons1 From the 1st Iterable", 
      build: () => bloc,
      act: (bloc) {
        bloc.add(LoadPersonAction(url: 'dummy_url1', loader: mockGetPersons1));
        bloc.add(LoadPersonAction(url: 'dummy_url1', loader: mockGetPersons1));
      },
      expect: () => [
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: true)
      ],
    );

    // Test: Fetch mock data (Persons 2) and compare it with mock result
    blocTest<PersonsBloc, FetchResult?>(
      "Mock Retrieving Persons2 From the 2nd Iterable", 
      build: () => bloc,
      act: (bloc) {
        bloc.add(LoadPersonAction(url: 'dummy_url2', loader: mockGetPersons2));
        bloc.add(LoadPersonAction(url: 'dummy_url2', loader: mockGetPersons2));
      },
      expect: () => [
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: true)
      ],
    );

  });


}