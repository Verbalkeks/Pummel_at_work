import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/widgets/custom_button.dart';

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  State<CreatePetScreen> createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  final _formKey = GlobalKey<FormState>();
  bool currentIsFemale = false;
  String? currentName;
  int? currentAge;
  double? currentHeight;
  double? currentWeight;
  Species? currentSpecies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neues Tier anlegen"),
      ),
      body: _CreatePetFormular(),
    );
  }

  SafeArea _CreatePetFormular() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _CreatePetTextFormField(
                  unitFullText: "Name",
                  unitShortText: "",
                  textInputType: TextInputType.text),
              _CreatePetTextFormField(
                  unitFullText: "Alter",
                  unitShortText: "Jahre",
                  textInputType: TextInputType.number),
              _CreatePetTextFormField(
                  unitFullText: "Höhe",
                  unitShortText: "cm",
                  textInputType: TextInputType.number),
              _CreatePetTextFormField(
                  unitFullText: "Gewicht",
                  unitShortText: "g",
                  textInputType: TextInputType.number),
              _ChoseSpeciesDropdown(),
              _IsFemaleCheckbox(),
              _ValidateAndSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  CustomButton _ValidateAndSubmitButton() {
    return CustomButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          final pet = Pet(
            id: "test",
            name: currentName!,
            species: currentSpecies!,
            age: currentAge!,
            weight: currentWeight!,
            height: currentHeight!,
            isFemale: currentIsFemale,
          );
          print("$pet");
        }
      },
      label: "Speichern",
    );
  }

  CheckboxListTile _IsFemaleCheckbox() {
    return CheckboxListTile(
      title: const Text("Weiblich"),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16,
      ),
      value: currentIsFemale,
      onChanged: (bool? value) {
        if (value != null) {
          print(value);
          setState(() {
            currentIsFemale = value;
          });
        }
      },
    );
  }

  DropdownButtonFormField<Species> _ChoseSpeciesDropdown() {
    return DropdownButtonFormField<Species>(
      hint: const Text("Bitte wählen Sie eine Spezies"),
      items: const [
        DropdownMenuItem(value: Species.dog, child: Text("Hund")),
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
        ),
      ],
      onChanged: (Species? value) {
        currentSpecies = value;
      },
      validator: (value) => value == null ? "Bitte Spezies angeben" : null,
    );
  }

  TextFormField _CreatePetTextFormField({
    required String unitFullText,
    required String unitShortText,
    required TextInputType textInputType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText:
            "$unitFullText${unitShortText.isEmpty ? "" : " ($unitShortText)"}:",
      ),
      onChanged: (value) {
        currentHeight = double.tryParse(value);
      },
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Bitte $unitFullText angeben";
        } else if (textInputType == TextInputType.number) {
          if (int.tryParse(value) == null) {
            return "Bitte eine Zahl eingeben";
          }
        }
        return null;
      },
    );
  }
}
