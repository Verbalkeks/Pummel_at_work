import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";
import "package:pummel_the_fish/theme/custom_colors.dart";

class DetailPetScreen extends StatelessWidget {
  // T3K14: Übung: DetailPetScreen mit Argumenten aufrufen
  // Das Pet-Objekt wird nun nicht mehr direkt übergeben
  // final Pet pet;

  const DetailPetScreen({
    super.key,
    // Das Pet-Objekt wird nun nicht mehr direkt übergeben
    // required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    // T3K14: Übung: DetailPetScreen mit Argumenten aufrufen
    // Das Pet-Objekt wird durch die ModalRoute.of(context)!.settings.arguments bezogen
    final pet = ModalRoute.of(context)!.settings.arguments as Pet;

    return PopScope(
      canPop: false, // verhindert automatisches Zurückspringen
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(context, "/home");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          title: Text(pet.name),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600; // Landscape / Tablet

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _BuildImageStack(pet, context),
                    ),
                    Expanded(
                      flex: 1,
                      child: _InfoCardsColumn(
                        pet: pet,
                      ),
                    ),
                  ],
                );
              }

              // VERTICAL → Standard Layout
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _BuildImageStack(pet, context),
                    _InfoCardsColumn(pet: pet),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Stack _BuildImageStack(Pet pet, BuildContext context) {
    return Stack(
      children: [
        _buildImage(pet.species),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 40,
            color: CustomColors.orangeTransparent,
            child: Center(
              child: Text(
                "Adoptier mich!",
                style: Theme.of(context).textTheme.headlineLarge
                ),
              ),
            ),
          ),
      ],
    );
  }

  // T3K13: Als Helper-Funktion
  Widget _buildImage(Species species) {
    switch (species) {
      case Species.dog:
        return Image.asset("assets/images/dog.png");
      case Species.bird:
        return Image.asset("assets/images/bird.png");
      case Species.cat:
        return Image.asset("assets/images/cat.png");
      case Species.fish:
        return Image.asset("assets/images/fish.png");
    }
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
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            _InfoCard(labelText: "Name des Kuscheltiers:", infoText: pet.name),
            _InfoCard(labelText: "Alter:", infoText: "${pet.age} Jahre"),
            _InfoCard(labelText: "Gewicht:", infoText: "${pet.weight} gramm"),
            _InfoCard(labelText: "Größe:", infoText: "${pet.height} cm"),
            _InfoCard(
                labelText: "Geschlecht:",
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

  const _InfoCard({
    required this.labelText,
    required this.infoText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText, style: Theme.of(context).textTheme.bodyMedium),
            Text(infoText, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
