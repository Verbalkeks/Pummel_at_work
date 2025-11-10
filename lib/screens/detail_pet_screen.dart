import 'package:flutter/material.dart';
import 'package:pummel_the_fish/data/models/pet.dart';

class DetailPetScreen extends StatelessWidget {
  final Pet pet;
  const DetailPetScreen({super.key, required Pet this.pet});

  @override
  Widget build(BuildContext context) {
  return PopScope(
    canPop: false, // verhindert das automatische Zurückspringen
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop) {
        Navigator.pushNamed(context, "/home");
      }
    },
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(pet.name),
      ),
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _HeaderStack(pet: pet),
                    _InfoCardsColumn(pet: pet),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _HeaderStack(pet: pet),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: _InfoCardsColumn(pet: pet),
                    ),
                  ),
                ],
              ),
      ),
    );
    )
    
  }
}

class _HeaderStack extends StatelessWidget {
  const _HeaderStack({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          pet.species == Species.dog
              ? "assets/images/dog.png"
              : pet.species == Species.bird
                  ? "assets/images/bird.png"
                  : pet.species == Species.cat
                      ? "assets/images/cat.png"
                      : "assets/images/fish.png",
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 40,
            color: const Color.fromARGB(80, 82, 7, 129),
            child: const Center(
              child: Text(
                "Adoptier mich!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCardsColumn extends StatelessWidget {
  const _InfoCardsColumn({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 24,
      ),
      child: Column(
        children: [
          _InfoCard(
            labelText: "Name des Kuscheltiers: ",
            infoText: pet.name,
          ),
          _InfoCard(
            labelText: "Alter:",
            infoText: "${pet.age}",
          ),
          _InfoCard(
            labelText: "Größe & Gewicht",
            infoText: "${pet.height} cm / ${pet.weight} g",
          ),
          _InfoCard(
              labelText: "Geschlecht",
              infoText: pet.isFemale ? "Weiblich" : "Männlich"),
          _InfoCard(
            labelText: "Spezies:",
            infoText: pet.species == Species.dog
                ? "Hund"
                : pet.species == Species.bird
                    ? "Vogel"
                    : pet.species == Species.cat
                        ? "Katze"
                        : "Fisch",
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String labelText;
  final String infoText;
  const _InfoCard({super.key, required this.labelText, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText),
            Expanded(
              child: Text(
                infoText,
                textAlign: TextAlign.end,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
