import 'package:flutter/foundation.dart' show immutable;
import 'package:rxdart_course/src/models/thing.dart';

enum AnimalType {dog, cat, rabbit, unknow}

@immutable class Animal extends Thing {
  final AnimalType type;
  // const Animal({required String name, required this.type}) : super(name: name);
  const Animal({required super.name, required this.type});
  @override
  String toString() {
    return 'Animal: $name, Type: $type';
  }

  factory Animal.fromJson(Map<String, dynamic> json){
    final AnimalType animalType;
    switch((json["type"] as String).toLowerCase().trim()){
      case "rabbit":
        animalType = AnimalType.rabbit;
      break;
            case "dog":
        animalType = AnimalType.dog;
      break;
            case "cat":
        animalType = AnimalType.cat;
      break;
      default:
        animalType = AnimalType.unknow;
      break;
    }
    return Animal(name: json["name"] as String, type: animalType);
  }
  
}