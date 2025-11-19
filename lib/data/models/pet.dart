import 'package:pummel_the_fish/data/models/owner.dart';
import 'dart:convert';

enum Species { dog, cat, bird, fish }

class Pet {
  final String id;
  final String name;
  final Species species;
  final int age;
  final double weight;
  final double height;
  final bool isFemale;
  final Owner? owner;

  const Pet(
      {required this.id,
      required this.name,
      required this.species,
      required this.age,
      required this.weight,
      required this.height,
      this.isFemale = true,
      this.owner});
  @override
  String toString() {
    return "Pet(id: $id,\nname: $name,\nspecies: $species,\nweight: $weight,\nheight: $height,\nage: $age,\nisFemale: $isFemale,\nowner: $owner,)";
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
        id: map["id"],
        name: map["name"],
        species: Species.values[map["species"]],
        age: map["age"] as int,
        weight: map["weight"]as double,
        height: map["height"]as double,
        isFemale: map["is_female"],
        owner: map["owner"] != null ? Owner.fromMap(map["owner"]) : null,
    );
  }
}
