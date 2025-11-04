import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/repositories/fake_pet_repository.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        /// FLUTTER 3.10.X / DART 3.0: die Farbe wurde hier von primarySwatch auf colorScheme geändert
        /// auf das colorScheme geändert.
        /// ALT: primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        /// FLUTTER 3.10.X / DART 3.0: useMaterial3 wurde hier hinzugefügt und auf true gesetzt
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pummel The Fish App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(80),
              child: Text('You have pushed the button this many times:'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
