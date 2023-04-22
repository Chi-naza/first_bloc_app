import 'package:bloc/bloc.dart';
import 'package:first_bloc_app/bloc-personsExample/bloc_actions.dart';
import 'package:first_bloc_app/bloc-personsExample/person.dart';
import 'package:flutter/foundation.dart' show immutable;



// A custom extension on Iterable
// Checks if two iterables are equal without using their ordering: checks their normal lengths & length of their intersections.
extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable other) => length == other.length && {...this}.intersection({...other}) == length; 
}





// Bloc Header
class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};

  PersonsBloc() : super(null){
    on<LoadPersonAction>((event, emit) async{
      final url =  event.url;
      if(_cache.containsKey(url)){
        // we have the value in the cache
        final cachedPersons = _cache[url]!;
        final result = FetchResult(
          persons: cachedPersons, 
          isRetrievedFromCache: true
        );
        emit(result);
      }else{
        final loader = event.loader;
        // we are retrieving fresh info from the loader (LoadActions).
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchResult(persons: persons, isRetrievedFromCache: false);
        emit(result);
      }
    });
  }
}





// The bloc state (OUTPUT)
@immutable class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({ required this.persons, required this.isRetrievedFromCache });

  @override
  String toString() {
    return "FetchResult (isRetrieved from cache = $isRetrievedFromCache, Persons: $persons)";
  }

  // overriding the equality
  @override
  bool operator == (covariant FetchResult other) => persons.isEqualToIgnoringOrdering(other.persons) && isRetrievedFromCache == other.isRetrievedFromCache;

  // overriding the hash function
  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
}
