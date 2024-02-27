import 'package:flutter/material.dart';

class ProductionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press event
        Navigator.pop(context);
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Production History'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ceraflaw_wallpaper.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          child: Center(
            child: Text('Content of Production History Screen'),
          ),
        ),
      ),
    );
  }
}
