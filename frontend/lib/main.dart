// Importing Flutter's material design library and HomeScreen widget from the ceraflaw package
import 'package:flutter/material.dart';
import 'package:ceraflaw/HomeScreen.dart';

void main() {
  // Running the CeraFlaw widget
  runApp(const CeraFlaw());
}

class CeraFlaw extends StatelessWidget {
  const CeraFlaw({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Disabling the debug banner
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Setting the background color of the Scaffold
        backgroundColor: Color.fromARGB(255, 215, 215, 215),
        body: Center(
          // Placing the HomeContent widget in the center
          child: HomeContent(), 
        ),
      ),
    );
  }
}
