import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/firestore_pet_repository.dart';
import 'package:pummel_the_fish/theme/custom_colors.dart';
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
  late final FirestorePetRepository firestorePetRepository;

  @override
  void initState() {
    super.initState();
    firestorePetRepository = FirestorePetRepository(firestore: FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neues Tier anlegen"),
      ),
      body: _createPetFormular(),
    );
  }

  SafeArea _createPetFormular() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).orientation == Orientation.portrait
            ? const EdgeInsets.all(24)
            : EdgeInsets.symmetric(
                vertical: 40,
                horizontal: MediaQuery.of(context).size.width / 5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _createPetTextFormField(
                  unitFullText: "Name",
                  unitShortText: "",
                  textInputType: TextInputType.text),
              _createPetTextFormField(
                  unitFullText: "Alter",
                  unitShortText: "Jahre",
                  textInputType: TextInputType.number),
              _createPetTextFormField(
                  unitFullText: "Höhe",
                  unitShortText: "cm",
                  textInputType: TextInputType.number),
              _createPetTextFormField(
                  unitFullText: "Gewicht",
                  unitShortText: "g",
                  textInputType: TextInputType.number),
              _choseSpeciesDropdown(),
              _isFemaleCheckbox(),
              _validateAndSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  CustomButton _validateAndSubmitButton() {
    return CustomButton(
      onPressed: _addPet,
      label: "Speichern",
    );
  }

  Future<void> _addPet() async {
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
      try {
        await firestorePetRepository.addPet(pet);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: CustomColors.blueDark,
            content: Text(
              "Kuscheltier erfolgreich hinzugefügt",
            ),
          ),
        );
      } on Exception {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: CustomColors.red,
            content: Text(
              "Fehler beim Hinzufügen des Kuscheltiers",
            ),
          ),
        );
      }
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  CheckboxListTile _isFemaleCheckbox() {
    return CheckboxListTile(
      title: Text(
        "Weiblich",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16,
      ),
      value: currentIsFemale,
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            currentIsFemale = value;
          });
        }
      },
    );
  }

  DropdownButtonFormField<Species> _choseSpeciesDropdown() {
    TextStyle bodyLarge = Theme.of(context).textTheme.bodyLarge!;
    return DropdownButtonFormField<Species>(
      hint: Text("Wählen Sie eine Spezies", style: bodyLarge),
      items: [
        DropdownMenuItem(
            value: Species.dog,
            child: Text(
              "Hund",
              style: bodyLarge.copyWith(color: CustomColors.blueMedium),
            )),
        DropdownMenuItem(
          value: Species.cat,
          child: Text(
            "Katze",
            style: bodyLarge.copyWith(color: CustomColors.blueMedium),
          ),
        ),
        DropdownMenuItem(
          value: Species.fish,
          child: Text(
            "Fisch",
            style: bodyLarge.copyWith(color: CustomColors.blueMedium),
          ),
        ),
        DropdownMenuItem(
          value: Species.bird,
          child: Text(
            "Vogel",
            style: bodyLarge.copyWith(color: CustomColors.blueMedium),
          ),
        ),
      ],
      onChanged: (Species? value) {
        currentSpecies = value;
      },
      validator: (value) => value == null ? "Bitte Spezies angeben" : null,
    );
  }

  TextFormField _createPetTextFormField({
    required String unitFullText,
    required String unitShortText,
    required TextInputType textInputType,
  }) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: CustomColors.blueMedium),
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText:
            "$unitFullText${unitShortText.isEmpty ? "" : " ($unitShortText)"}:",
      ),
      onChanged: (value) {
        setState(() {
          switch (unitFullText) {
            case "Name":
              currentName = value;
              break;
            case "Alter":
              currentAge = int.tryParse(value);
              break;
            case "Höhe":
              currentHeight = double.tryParse(value);
              break;
            case "Gewicht":
              currentWeight = double.tryParse(value);
              break;
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Bitte $unitFullText angeben";
        }
        if (textInputType == TextInputType.number &&
            double.tryParse(value) == null) {
          return "Bitte eine gültige Zahl eingeben";
        }
        return null;
      },
    );
  }
}
