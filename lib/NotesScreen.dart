import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ceraflaw_wallpaper.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
        ),
        child:Center(
          child: Text('Content of Notes Screen'),
        ),
      )
    );
  }
}
