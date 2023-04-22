import 'package:first_bloc_app/bloc-personsExample/person.dart';
import 'package:flutter/foundation.dart' show immutable;




typedef PersonLoader = Future<Iterable<Person>> Function(String url);

const personUrl1 = "http://127.0.0.1:5500/api/persons1.json";
const personUrl2 = "http://127.0.0.1:5500/api/persons2.json";


// NB: Events are bloc inputs & Emit is the output of your Bloc

// For wrapping up multiple events and states
@immutable abstract class LoadAction {
  const LoadAction();
}



// Bloc input (i.e the Event)
@immutable class LoadPersonAction implements LoadAction {
  final String url;
  final PersonLoader loader;
  LoadPersonAction({required this.url, required this.loader}) : super();
}



// enum
// enum Personurl {
//   persons1,
//   persons2
// }


// extension UrlString on Personurl {
//   String get urlString {
//     switch(this){
      
//       case Personurl.persons1:
//         return "http://127.0.0.1:5500/api/persons1.json";
//         break;
//       case Personurl.persons2:
//         return "http://127.0.0.1:5500/api/persons2.json";
//         break;
//     }
//   }
// }

