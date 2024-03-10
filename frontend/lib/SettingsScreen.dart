import 'package:flutter/material.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';

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
                image: AssetImage("assets/ceraflaw_wallpaper.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          //Select Language (Not Implemented)
          Positioned(
            top: 20,
            right: 20,
            child: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: <String>['English', 'Sinhala']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
