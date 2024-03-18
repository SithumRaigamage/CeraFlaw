import 'package:ceraflaw/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CeraFlaw());
}

class CeraFlaw extends StatelessWidget {
  const CeraFlaw({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(   //frame size is not working need to check on that
      width: 500,
      height: 500,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ceraflaw_wallpaper.jpg"),   //setting the wallpaper
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
            child: const Center(
              child:HomeContent(),    //adding the homeScreen 
            ),
          ),
        ),
      ),
    );
  }
}