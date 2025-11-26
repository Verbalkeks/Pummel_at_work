import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';
import 'package:pummel_the_fish/data/repositories/firestore_pet_repository.dart';
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
  late final FirestorePetRepository firestorePetRepository;
  late Future<List<Pet>> pets;

  @override
  void initState() {
    super.initState();
    final httpClient = http.Client();
    firestorePetRepository = FirestorePetRepository(
      firestore: FirebaseFirestore.instance
    );

    pets = firestorePetRepository.getAllPets();
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
            pets = firestorePetRepository.getAllPets();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
