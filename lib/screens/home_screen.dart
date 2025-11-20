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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final petRepository = FakePetRepository();
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    pets = petRepository.getAllPets();
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
          child: ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  pets[index].isFemale ? Icons.female : Icons.male,
                  color: CustomColors.orange,
                  size: 40,
                ),
                title: Text(
                  pets[index].name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  "Alter: ${pets[index].age} Jahre ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: CustomColors.blueMedium,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/detail",
                    arguments: pets[index],
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create");
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllPets() async {
    final httpClient = http.Client();
    final restPetRepository = RestPetRepository(httpClient: httpClient);
    final pets = await restPetRepository.getAllPets();
    for (Pet pet in pets) {
      final data = await restPetRepository.getPetById(pet.id);
      print(data.toString());
      await Future.delayed(const Duration(milliseconds: 1500));
    }
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
