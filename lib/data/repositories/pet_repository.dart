import 'package:pummel_the_fish/data/models/pet.dart';

/// Diese abstrakte Klasse dient als Schablone
/// für das RestPetRepository, FakePetRepository und
/// FirebasePetRepository. Alle Methoden müssen beim
/// Verwenden dieser Schablone mit @override überschrieben werden
abstract class PetRepository {
  Pet? getPetById(String id);
  List<Pet> getAllPets();
  void addPet(Pet pet);
  void deletePetById(String id);
  void updatePet(Pet pet);
}
