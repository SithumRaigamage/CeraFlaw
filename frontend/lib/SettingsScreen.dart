import 'package:flutter/material.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSelected = false;
  String path = "assets/ceraflaw_wallpaper.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(path),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 80,
            child: Switch(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    isSelected = value;
                    if (isSelected == true) {
                    } else {}
                  });
                }),
          ),

          //Delete Button
          Positioned(
            top: 100,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                //Data location
                String framesDirectory = "../backend/Frames";

                //if the location exsist
                Directory(framesDirectory).exists().then((directoryExists) {
                  if (directoryExists) {
                    //clear data
                    Directory(framesDirectory).listSync().forEach((entity) {
                      if (entity is File) {
                        entity.deleteSync();
                      }
                    });
                    //successful
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data Cleared')),
                    );
                  } else {
                    //location not found
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Frames directory not found')),
                    );
                  }
                });
              },
              //button text
              child: Text(
                'Clear Capture Data',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
