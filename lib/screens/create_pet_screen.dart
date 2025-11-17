import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/screens/home_screen.dart';
import 'package:pummel_the_fish/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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
        padding: MediaQuery.of(context).orientation == Orientation.portrait
            ? EdgeInsets.all(24)
            : EdgeInsets.symmetric(
                vertical: 40,
                horizontal: MediaQuery.of(context).size.width / 5),
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
          Navigator.pop(context);
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
        DropdownMenuItem(
          value: Species.dog,
          child: FaIcon(FontAwesomeIcons.dog)
        ),
        DropdownMenuItem(
          value: Species.cat,
          child: FaIcon(FontAwesomeIcons.cat),
        ),
        DropdownMenuItem(
          value: Species.fish,
          child: FaIcon(FontAwesomeIcons.fish),
        ),
        DropdownMenuItem(
          value: Species.bird,
          child: FaIcon(FontAwesomeIcons.earlybirds),
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
