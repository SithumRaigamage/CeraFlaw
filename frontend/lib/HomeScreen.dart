// Import necessary packages and files
import 'dart:io';
import 'package:flutter/material.dart';
import 'StartScreen.dart';
import 'ManualScreen.dart';
import 'ProductionHistoryScreen.dart';
import 'SettingsScreen.dart';
import 'NotesScreen.dart';

// Defining a new widget for home page
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  //New instance of the state related to this widget
  @override
  _HomeContentState createState() => _HomeContentState();
}

// Defining the state for the HomeContent widget
class _HomeContentState extends State<HomeContent> {
  late List<bool> _isHovered;

  // Initializing the hover state for each column in the widget
  @override
  void initState() {
    super.initState();
    _isHovered = List<bool>.generate(6, (index) => false);
  }

  // UI of this widget
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CeraFlaw logo
        Image.asset('assets/logo.png', width: 250, height: 250),
        const SizedBox(height: 20),
        // Creating buttons
        Wrap(
          spacing: 50,
          runSpacing: 10,
          children: [
            // buildHoverEffectColumn method for each column
            buildHoverEffectColumn(0, 'assets/dark_icons/play-button-black.png', 'Start', () {
              _navigateToScreen(context, const StartScreen());
            }),
            buildHoverEffectColumn(1, 'assets/dark_icons/manual-black.png', 'Manual', () {
              _navigateToScreen(context, const ManualScreen());
            }),
            buildHoverEffectColumn(
                2, 'assets/dark_icons/time-black.png', 'Production History', () {
              _navigateToScreen(context, const ProductionHistoryScreen());
            }),
            buildHoverEffectColumn(3, 'assets/dark_icons/settings-black.png', 'Settings', () {
              _navigateToScreen(context, const SettingsScreen());
            }),
            buildHoverEffectColumn(4, 'assets/dark_icons/notes-black.png', 'Notes', () {
              _navigateToScreen(context, const NotesScreen());
            }),
            buildHoverEffectColumn(5, 'assets/dark_icons/exit.png', 'Quit', () {
              exit(0); //exit condition
            }),
          ],
        ),
      ],
    );
  }

  // handling the hover effect for a button
  Widget buildHoverEffectColumn(
      int index, String imagePath, String label, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered[index] = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered[index] = false;
        });
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: _isHovered[index] ? Colors.black : Colors.transparent,
                width: 4), //border settings
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 80, height: 80), //icon image
              const SizedBox(height: 10),
              Text(
                label, //icon label
                style: const TextStyle(
                  fontWeight: FontWeight.bold, //icon label settings
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Handling the navigation related to the button
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
