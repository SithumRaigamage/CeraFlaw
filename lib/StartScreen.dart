
import 'package:flutter/material.dart';

void main() {
  runApp(StartScreen());
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Grid and Flow Layout',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid and Flow Layout'),
        ),
        body: GridAndFlowLayout(),
      ),
    );
  }
}

class GridAndFlowLayout extends StatefulWidget {
  @override
  _GridAndFlowLayoutState createState() => _GridAndFlowLayoutState();
}

class _GridAndFlowLayoutState extends State<GridAndFlowLayout> {
  String batchId = '';

  void _handleSubmit(BuildContext context) {
    // Validate if the batchId contains only letters and numbers
    bool isValid = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(batchId);

    if (isValid) {
      // Navigate to the new screen if input is valid
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmitScreen(batchId: batchId),
        ),
      );
    } else {
      // Show an alert if input is invalid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter only letters and numbers for Batch ID.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return GridTile(
                child: Column(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle button press
                        },
                        icon: Image.asset(
                          'assets/image.png',
                          fit: BoxFit.cover,
                        ),
                        label: Text('Button $index'),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Batch Id',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      batchId = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _handleSubmit(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SubmitScreen extends StatelessWidget {
  final String batchId;

  SubmitScreen({required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Screen'),
      ),
      body: Center(
        child: Text('Submitted Batch ID: $batchId'),
      ),
    );
  }
}
