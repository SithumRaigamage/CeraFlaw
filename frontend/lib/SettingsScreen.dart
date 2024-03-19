import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    // Load switch state from persistent storage
    _loadSwitchState();
  }

  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelected = prefs.getBool('isSelected') ?? false;
    });
  }

  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSelected', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isSelected ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 28,
              right: 160,
              child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(isSelected
                    ? "assets/white_icons/sun.png"
                    : "assets/dark_icons/moon.png"),
              )),

          Positioned(
            top: 25,
            right: 80,
            child: Switch(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    isSelected = value;
                  });
                  _saveSwitchState(value);
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
                      const SnackBar(content: Text('Data Cleared')),
                    );
                  } else {
                    //location not found
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Frames directory not found')),
                    );
                  }
                });
              },
              //button text
              child: Text(
                'Clear Capture Data',
                style: TextStyle(
                  color: isSelected ? Colors.deepPurple : Colors.black,
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
