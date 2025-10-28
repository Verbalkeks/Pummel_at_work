import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:collection/collection.dart';

class FakePetRepository {
  final List<Pet> _pets = [
    const Pet(
      id: "1",
      name: "Pummel",
      species: Species.fish,
      weight: 200.0,
      height: 20.0,
      age: 3,
    ),
    const Pet(
      id: "2",
      name: "Bruno",
      species: Species.dog,
      weight: 320.0,
      height: 60.0,
      age: 4,
      isFemale: false,
    ),

    const Pet(
      id: "3",
      name: "Leonie",
      species: Species.cat,
      weight: 400.0,
      height: 45.0,
      age: 6,
    ),
    const Pet(
      id: "4",
      name: "Harribart",
      species: Species.bird,
      weight: 220.0,
      height: 10.0,
      age: 1,
      isFemale: false,
    ),
  ];
  FakePetRepository();

  // es folgenden normale CRUD-Methoden

  // CREATE
  void addPet(Pet pet) {
    _pets.add(pet);
  }

  // UPDATE
  void updatePet(Pet pet) {
    final index = _pets.indexWhere((element) => element.id == pet.id);
    if (index != -1) {
      _pets[index] = pet;
    }
  }

  // READ
  // By-ID
  Pet? getPetById(String id) {
    return _pets.firstWhereOrNull((petElement) => petElement.id == id);
  }

  // sorted List
  List<Pet> getAllPets() {
    _sortPetsByName();
    return _pets;
  }

  // DELETE

  void deletePetById(String id) {
    _pets.removeWhere((pet) => pet.id == id);
  }

  // Methode zum sortieren der Liste
  void _sortPetsByName() {
    _pets.sort((pet1, pet2) => pet1.name.compareTo(pet2.name));
  }

  // Coolen Namen generieren lassen
  static String makeACoolPetName(String nameILike, Species species) {
    String coolName = "$nameILike the ${species.name}";
    return coolName;
  }
}
