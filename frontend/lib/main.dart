import 'package:ceraflaw/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CeraFlaw());
}

class CeraFlaw extends StatelessWidget {
  const CeraFlaw({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(   //frame size is not working need to check on that
      width: 500,
      height: 500,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ceraflaw_wallpaper.jpg"),   //setting the wallpaper
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
            child: Center(
              child:HomeContent(),    //adding the homeScreen 
            ),
          ),
        ),
      ),
    );
  }
}