import 'dart:convert';
import 'dart:io';

import 'package:rxdart_course/src/models/animal.dart';
import 'package:rxdart_course/src/models/person.dart';
import 'package:rxdart_course/src/models/thing.dart';

typedef SearchTerm = String;

class Api {
  List<Animal>? _animals;
  List<Person>? _persons;

  Api();

  Future<List<Thing>> search(SearchTerm searchTerm) async {
    final term = searchTerm.trim().toLowerCase();

    //search in the cache
    final cachedResults = _extratThingUsingSearchTerm(term);
    if (cachedResults != null) {
      return cachedResults;
    }

    //API call animal
    final animals = await _getJson("http://localhost/api/animals.json")
        .then((json) => json.map((value) => Animal.fromJson(value)));
    _animals = animals.toList();
    //API call person
    final persons = await _getJson("http://localhost/api/person.json")
        .then((json) => json.map((value) => Person.fromJson(value)));
    _persons = persons.toList();

    return _extratThingUsingSearchTerm(term) ?? [];
  }

  List<Thing>? _extratThingUsingSearchTerm(SearchTerm term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;
    List<Thing> result = [];
    if (cachedPersons != null && cachedAnimals != null) {
      for (final animal in cachedAnimals) {
        // ! Get Animals
        if (animal.name.trimmedContains(term) ||
            animal.type.name.trimmedContains(term)) {
          result.add(animal);
        }
      }

      for (final person in cachedPersons) {
        // ! Get Animals
        if (person.name.trimmedContains(term) ||
            person.age.toString().trimmedContains(term)) {
          result.add(person);
        }
      }
      return result;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getJson(String url) => HttpClient()
      .getUrl(Uri.parse(url))
      .then((request) => request.close())
      .then((response) => response.transform(utf8.decoder).join(""))
      .then((jsonString) => json.decode(jsonString) as List<dynamic>);
}
  
extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) =>
      trim().toLowerCase().contains(other.trim().toLowerCase());
}
