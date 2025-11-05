import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';

class CreatePetScreen extends StatelessWidget {
  const CreatePetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neues Tier anlegen"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Alter (Jahre)",
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Höhe (cm)",
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Gewicht (Gramm)",
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                DropdownButtonFormField<Species>(
                  hint: const Text("Bitte wählen sie eine Spezies"),
                  items: const [
                    DropdownMenuItem(
                      value: Species.dog,
                      child: Row(
                        children: [
                          Icon(Icons.pets),

                        ]
                      ),
                    ),
                    DropdownMenuItem(
                      value: Species.cat,
                      child: Text("Katze"),
                    ),
                    DropdownMenuItem(
                      value: Species.fish,
                      child: Text("Fisch"),
                    ),
                    DropdownMenuItem(
                      value: Species.bird,
                      child: Text("Vogel"),
                    )
                  ],
                  onChanged: (Species? value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
