import 'dart:async';

import 'package:pummel_the_fish/data/models/pet.dart';

/// Diese abstrakte Klasse dient als Schablone
/// für das RestPetRepository, FakePetRepository und
/// FirebasePetRepository. Alle Methoden müssen beim
/// Verwenden dieser Schablone mit @override überschrieben werden
abstract class PetRepository {
  FutureOr<Pet?> getPetById(String id);
  FutureOr<List<Pet>> getAllPets();
  FutureOr<void> addPet(Pet pet);
  FutureOr<void> deletePetById(String id);
  FutureOr<void> updatePet(Pet pet);
}
