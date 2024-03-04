import 'package:flutter/material.dart';

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
            child: Center(
              child: Text('Content of Settings Screen'),
            ),
          ),
          // Diagonal Banner
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3, // Adjust the height as needed
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              transform: Matrix4.rotationZ(-0.785398),
              color: Colors.red, // Choose your banner color
              child: Text(
                _selectedLanguage == 'English' ? 'In Development' : 'ක්‍රියාකාරී තැන්',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Language Selector
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
        ],
      ),
    );
  }
}
