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
      age: map["age_in_years"].toInt(),
      weight: map["weight"].toDouble(),
      height: map["height"].toDouble(),
      isFemale: map["is_female"],
      owner: map["owner"] != null ? Owner.fromMap(map["owner"]) : null,
    );
  }

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"id": id});
    result.addAll({"name": name});
    result.addAll({"species": species.index});
    result.addAll({"age_in_years": age});
    result.addAll({"weight": weight});
    result.addAll({"height": height});
    result.addAll({"is_female": isFemale});
    if (owner != null) {
      result.addAll({"owner": owner!.toMap()});
    }
    return result;
  }

  Pet copyWith({
    String? id,
    String? name,
    Species? species,
    int? age,
    double? weight,
    double? height,
    bool? isFemale,
    Owner? owner,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      isFemale: isFemale ?? this.isFemale,
      owner: owner ?? this.owner,
    );
  }
}
