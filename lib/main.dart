import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';

// class ExampleWidget extends StatelessWidget {
//   const ExampleWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // Hier wird das Widget gebaut
//   }
// }

// class ExampleWidget extends StatefulWidget {
//   const ExampleWidget({super.key});
//   @override
//   State<ExampleWidget> createState() => _ExampleWidgetState();
// }

// class _ExampleWidgetState extends State<ExampleWidget> {
//   @override
//   Widget build(BuildContext context) {
//     // Hier wird das Widget gebaut
//   }
// }

Future<void> main() async {
  // T2K7: Futures, async und await
  final petRepository = FakePetRepository();

  // // mit await-Schreibweise
  // print("/////\nawait Schreibweise");
  // final pets = await petRepository.getAllPetsFromMockServer();
  // for (var pet in pets) {
  //   print(pet.name);
  // }

  // // oder mit .then-Schreibweise
  // print("/////\n.Then schreibweise.");
  // await petRepository.getAllPetsFromMockServer().then(
  //   (pets) => {
  //     for (var pet in pets) {print(pet.name)},
  //   },
  // );

  // // T2K7: Ein Datenfluss - auch Stream genannt
  // final foodStream = Stream<String>.periodic(
  //   const Duration(milliseconds: 1250),
  //   (count) => "Hundefutter ${count+1}",
  // );

  // // Vertrag unterschreiben
  // final foodStreamSubscription = foodStream.listen((food) => print(food));

  // // Vertrag kündigen nach gewisser Zeit
  // final pause = Future.delayed(const Duration(milliseconds: 500), () {
  //   foodStreamSubscription.cancel();
  //   print("subscription von Hundefutter beendet");
  // });

  // // T2K7: Ein Stream als Rückgabewert
  // final foodDeliveries = ["Dog Food", "Cat Food", "Bird Food"];
  // Stream<String> getFoodFromDelivery(List<String> foodDeliveries) async* {
  //   for (final food in foodDeliveries) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     yield food;
  //   }
  // }

  // getFoodFromDelivery(foodDeliveries).listen((food) {
  //   print(food);
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const brunoTheDog = Pet(
    //   id: "2",
    //   name: "Bruno",
    //   species: Species.dog,
    //   weight: 320.0,
    //   height: 60.0,
    //   age: 4,
    //   isFemale: false,
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const CreatePetScreen(),
    );
  }
}
