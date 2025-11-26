import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';

const petCollection = "pets";

class FirestorePetRepository implements PetRepository {
  final FirebaseFirestore firestore;

  FirestorePetRepository({
    required this.firestore,
  });

  @override
  Future<List<Pet>> getAllPets() async {
    final petSnapshots = await firestore.collection(petCollection).get();

    final petList = petSnapshots.docs
        .map((snapshot) => Pet.fromMap(snapshot.data()))
        .toList();

    return petList;
  }

  @override
  Future<void> addPet(Pet pet) async {
    final emptyDocument = await firestore.collection(petCollection).add({});

    final petWithId = Pet(
      id: emptyDocument.id,
      name: pet.name,
      species: pet.species,
      age: pet.age,
      weight: pet.weight,
      height: pet.height,
      isFemale: pet.isFemale,
      owner: pet.owner,
    );

    emptyDocument.set(petWithId.toMap());
  }

  @override
  Future<void> updatePet(Pet pet) async {
    await firestore.collection(petCollection).doc(pet.id).update(pet.toMap());
  }

  @override
  Future<Pet?> getPetById(String petId) async {
    final document = await firestore.collection(petCollection).doc(petId).get();

    if (document.data() != null) {
      return Pet.fromMap(document.data()!);
    }

    return null;
  }

  @override
  Future<void> deletePetById(String id) async {
    await firestore.collection(petCollection).doc(id).delete();
  }

  Future<List<Pet>> getPetBySpecies(Species species) async {
    final petsSnapshot = await firestore
        .collection(petCollection)
        .where("species", isEqualTo: species.index)
        .get();

    final petList =
        petsSnapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();
    return petList;
  }

  Future<List<Pet>> getPetsOrderedByHeight() async {
    final petsSnapshot = await firestore
        .collection(petCollection)
        .orderBy("height", descending: true)
        .get();
    final petList = petsSnapshot.docs
        .map((doc) => Pet.fromMap(doc.data()))
        .toList();
    return petList;
  }
}
