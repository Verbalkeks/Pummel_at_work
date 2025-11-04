import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 24, 8),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}