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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pummel The Fish',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/create": (context) => const CreatePetScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/detail") {
          final pet = settings.arguments as Pet;
          return MaterialPageRoute(
            builder: (context) => DetailPetScreen(pet: pet),
          );
        }
        return null;
      },
    );
  }
}
