import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CeraFlaw',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GridButtonsScreen(),
        '/start': (context) => StartScreen(),
        '/manual': (context) => ManualScreen(),
        '/history': (context) => HistoryScreen(),
        '/settings': (context) => SettingsScreen(),
        '/notes': (context) => NotesScreen(),
        '/quit': (context) => QuitScreen(),
      },
    );
  }
}

class GridButtonsScreen extends StatelessWidget {
  // Define a list of button names
  final List<String> buttonNames = [
    'Start',
    'Manual',
    'History',
    'Settings',
    'Notes',
    'Quit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CeraFlaw'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 70.0), // Add margin from the top
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(buttonNames.length, (index) {
              return Center(
                child: GridButton(
                  // Use separate names for buttons from the list
                  buttonText: buttonNames[index],
                  iconPath: 'assets/icons/icon${index + 1}.png',
                  onPressed: () {
                    Navigator.pushNamed(context, '/${buttonNames[index].toLowerCase()}');
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  final String buttonText;
  final String iconPath;
  final VoidCallback onPressed;

  GridButton({required this.buttonText, required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 50, // Adjust width as per your requirement
            height: 50, // Adjust height as per your requirement
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Screen'),
      ),
      body: Center(
        child: Text('This is the Start Screen'),
      ),
    );
  }
}

class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Screen'),
      ),
      body: Center(
        child: Text('This is the Manual Screen'),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Screen'),
      ),
      body: Center(
        child: Text('This is the History Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body: Center(
        child: Text('This is the Settings Screen'),
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Screen'),
      ),
      body: Center(
        child: Text('This is the Notes Screen'),
      ),
    );
  }
}

class QuitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quit Screen'),
      ),
      body: Center(
        child: Text('This is the Quit Screen'),
      ),
    );
  }
}
