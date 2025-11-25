import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';
import 'package:pummel_the_fish/data/repositories/pet_repository.dart';
import 'package:pummel_the_fish/data/repositories/rest_pet_repository.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';
import 'package:pummel_the_fish/theme/custom_colors.dart';
import 'package:pummel_the_fish/widgets/pet_list_error.dart';
import 'package:pummel_the_fish/widgets/pet_list_loaded.dart';
import 'package:pummel_the_fish/widgets/pet_list_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final RestPetRepository restPetRepository;
  late Future<List<Pet>> pets;

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    restPetRepository = RestPetRepository(
      httpClient: httpClient,
    );

    pets = restPetRepository.getAllPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset("assets/images/pummel.png"),
        ),
        title: const Text("Pummel The Fish"),
        actions: [
          IconButton(
              onPressed: () => _addNewPet(), icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder<List<Pet>>(
            initialData: const [],
            future: pets,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const PetListLoading();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return PetListLoaded(pets: snapshot.data!);
                  } else {
                    return const PetListError(
                      message: "Fehler beim Laden der Tiere",
                    );
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/create");
          setState(() {
            pets = restPetRepository.getAllPets();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Pet>> _getAllPets() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(httpClient: httpClient);
    final pets = await restPetRepository.getAllPets();
    return pets;
  }

  Future<void> _addNewPet() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(httpClient: httpClient);
    const keksTheDog = Pet(
      id: "612",
      name: "Keks",
      species: Species.dog,
      weight: 250.0,
      height: 45.0,
      age: 10,
    );

    await restPetRepository.addPet(keksTheDog);
  }
}
