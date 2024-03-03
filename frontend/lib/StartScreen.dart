
import 'package:ceraflaw/detectionScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(StartScreen());
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Grid and Flow Layout',
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          // Handle back button press here
          return true; // return true to allow back navigation
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Grid and Flow Layout'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
          ),
          body: GridAndFlowLayout(),
        ),
      ),
    );
  }
}

class GridAndFlowLayout extends StatefulWidget {
  @override
  _GridAndFlowLayoutState createState() => _GridAndFlowLayoutState();
}

class _GridAndFlowLayoutState extends State<GridAndFlowLayout> {
  late String batchIdController;
  List<double> tileSizes = List.generate(9, (index) => 100.0); // List to hold preferred tile sizes for each button

  @override
  void initState() {
    super.initState();
    batchIdController = '';
  }

  void _handleSubmit(BuildContext context) {
    if (batchIdController.isNotEmpty) {
      bool isValid = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(batchIdController);

      if (isValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionScreen(batchId: batchIdController),
          ),
        );
      } else {
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Empty Batch ID'),
          content: Text('Please enter a Batch ID before submitting.'),
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
                child: SizedBox(
                  width: tileSizes[index],
                  height: tileSizes[index],
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Button $index'), // Text can be customized here
                  ),
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
                      batchIdController = value;
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
