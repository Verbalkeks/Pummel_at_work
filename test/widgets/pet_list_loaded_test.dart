import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/widgets/pet_list_loaded.dart';

void main() {
  
  late List<Pet> tPets;
  setUp(() {
    tPets = [
      const Pet(
        id: "1",
        name: "Pummel",
        species: Species.fish,
        weight: 200.0,
        height: 20.0,
        age: 3,
      ),
      const Pet(
        id: "2",
        name: "Bruno",
        species: Species.dog,
        weight: 320.0,
        height: 60.0,
        age: 4,
        isFemale: false,
      ),
      const Pet(
        id: "3",
        name: "Leonie",
        species: Species.cat,
        weight: 400.0,
        height: 45.0,
        age: 6,
      ),
      const Pet(
        id: "4",
        name: "Harribart",
        species: Species.bird,
        weight: 220.0,
        height: 10.0,
        age: 1,
        isFemale: false,
      )
    ];
  });
  testWidgets('should display all given Pets', (tester) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PetListLoaded(pets: tPets))));
    for (var pet in tPets) {
      expect(find.text(pet.name), findsOneWidget);
      expect(find.byKey(ValueKey("pet-${pet.id}")), findsOneWidget);
    }
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.female), findsNWidgets(2));
    expect(find.byIcon(Icons.male), findsNWidgets(2));
  });
}
