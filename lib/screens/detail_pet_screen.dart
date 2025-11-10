import "package:flutter/material.dart";
import "package:pummel_the_fish/data/models/pet.dart";

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
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // T3K13: Als Wenn-Dann-Verzweigung
                  /* Image.asset(
                  pet.species == Species.dog
                      ? "assets/images/dog.png"
                      : pet.species == Species.bird
                          ? "assets/images/bird.png"
                          : pet.species == Species.cat
                              ? "assets/images/cat.png"
                              : "assets/images/fish.png",
                ), */
                  // T3K14: Als Helper-Funktion
                  _buildImage(pet.species),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 40,
                      color: const Color(0x88FFC942),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: Column(
                  children: <Widget>[
                    _InfoCard(
                      labelText: "Name des Kuscheltiers:",
                      infoText: pet.name,
                    ),
                    _InfoCard(
                      labelText: "Alter:",
                      infoText: "${pet.age} Jahre",
                    ),
                    _InfoCard(
                      labelText: "Gewicht:",
                      infoText: "${pet.weight} gramm",
                    ),
                                        _InfoCard(
                      labelText: "Größe:",
                      infoText: "${pet.height} cm",
                    ),
                    _InfoCard(
                      labelText: "Geschlecht:",
                      infoText: pet.isFemale ? "Weiblich" : "Männlich",
                    ),
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
              ),
            ],
          ),
        ),
      ),
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
            Text(labelText),
            Text(infoText),
          ],
        ),
      ),
    );
  }
}