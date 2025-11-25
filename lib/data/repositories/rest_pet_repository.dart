import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://losfluttern.de/pummelthefish/api";

class RestPetRepository implements PetRepository {
  final http.Client httpClient;

  RestPetRepository({required this.httpClient});

  @override
  Future<void> addPet(Pet pet) async {
    final uri = Uri.parse("$baseUrl/pets");

    final response = await httpClient.post(
      uri,
      body: pet.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 201) {
      print("Kuscheltier erfolgreich hinzugefügt");
      return;
    } else {
      throw Exception("Beim Hinzufügen des Kuscheltiers ging etwas schief");
    }
  }

  @override
  Future<List<Pet>> getAllPets() async {
    final uri = Uri.parse("$baseUrl/pets");
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(response.body);
      final petList = dataList.map((petMap) => Pet.fromMap(petMap)).toList();
      return petList;
    } else {
      throw Exception(
        "Beim Laden der Kuscheltiere ging etwas schief.",
      );
    }
  }

  @override
  Future<Pet?> getPetById(String id) async {
    final uri = Uri.parse("$baseUrl/pets/$id");
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return Pet.fromMap(data);
    } else {
      throw Exception("Kuscheltier nicht gefunden");
    }
  }

  @override
  Future<void> updatePet(Pet pet) async {
    final uri = Uri.parse("$baseUrl/pets/${pet.id}");
    final response = await httpClient.put(
      uri,
      body: pet.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      print("Kuscheltier erfolgreich aktualisiert.");
      return;
    } else {
      throw Exception("Beim Aktualisieren des Pets ging etwas schief");
    }
  }

  @override
  Future<void> deletePetById(String id) async {
    final uri = Uri.parse("$baseUrl/pets/${id}");
    final response = await httpClient.delete(uri);
    if (response.statusCode == 204) {
      print("GoodBye Kuscheltier.");
      return;
    } else {
      throw Exception("Beim Löschen des Kuscheltiers ging etwas schief");
    }
  }
}
