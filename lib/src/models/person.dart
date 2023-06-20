import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart_course/src/models/thing.dart';

@immutable
class Person extends Thing {
  final int age;
  // const Person({required String name, required this.type}) : super(name: name);
  const Person({required super.name, required this.age});
  @override
  String toString() {
    return 'Person, name: $name, Age: $age';
  }
  Person.fromJson(Map<String, dynamic> json)
      : age = json["age"] as int,
        super(name: json["name"] as String);
}
