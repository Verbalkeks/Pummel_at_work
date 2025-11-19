import 'dart:io';

import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://losfluttern.de/pummelthefish/api";

class RestPetRepository implements PetRepository {
  final http.Client httpClient;

  RestPetRepository({required this.httpClient});

  @override
  void addPet(Pet pet) {
    // TODO: Pet an den Server senden und dort speichern
    throw UnimplementedError();
  }

  @override
  Future<List<Pet>> getAllPets() async {
    final uri = Uri.parse("$baseUrl/pets");
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(response.body);
      print(dataList);
      throw UnimplementedError();
    } else {
      throw Exception(
        "Beim Laden der Kuscheltiere ging etwas schief.",
      );
    }
  }

  @override
  Pet? getPetById(String id) {
    // TODO: ein bestimmtes Pet abrufen
    throw UnimplementedError();
  }

  @override
  void updatePet(Pet pet) {
    // TODO: existierendes Pet auf dem Server aktualisieren
    throw UnimplementedError();
  }

  @override
  void deletePetById(String id) {
    // TODO: existierendes Pet auf dem Server löschen
    throw UnimplementedError();
  }
}
