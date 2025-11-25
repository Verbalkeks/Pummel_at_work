import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';
import 'package:pummel_the_fish/screens/create_pet_screen.dart';
import 'package:pummel_the_fish/screens/detail_pet_screen.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/screens/splash_screen.dart';
import 'package:pummel_the_fish/theme/custom_colors.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pummel The Fish',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomColors.blueLight,
          foregroundColor: CustomColors.white,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: CustomColors.blueDark,
          onPrimary: CustomColors.white,
          secondary: CustomColors.orange,
          onSecondary: CustomColors.white,
          error: CustomColors.red,
          onError: CustomColors.white,
          surface: CustomColors.white,
          onSurface: CustomColors.blueLight,
        ),
        
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: CustomColors.blueDark,
          ),
          floatingLabelStyle: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CustomColors.blueDark,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.blueDark),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.blueLight,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.red),
          ),
        ),
        fontFamily: "Comfortaa",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: CustomColors.blueDark,
          ),
          titleMedium: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: CustomColors.blueMedium,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: CustomColors.blueDark,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: CustomColors.blueDark,
          ),
          bodySmall: TextStyle(
            fontFamily: "Titillium Web",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: CustomColors.blueDark,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
        "/create": (context) => const CreatePetScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/detail") {
          final pet = settings.arguments as Pet;
          return MaterialPageRoute(
            builder: (context) => const DetailPetScreen(),
            settings: settings, // wichtig, damit arguments weitergegeben werden
          );
        }
        return null;
      },
    );
  }
}
