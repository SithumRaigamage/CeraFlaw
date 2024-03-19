import 'package:flutter/material.dart';
import 'detectionScreen.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _appBarTitle = 'Select Tile';
  final TextEditingController _textController = TextEditingController();
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appBarTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: buildImageTile(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: buildTextFieldAndButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageTile() {
    return GestureDetector(
      key: const ValueKey('tile'),
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/marbletile.jpeg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text('T001'),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldAndButton() {
    const String tileID = "T001";
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter Batch ID',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: ElevatedButton(
            onPressed: () {
                handleButtonClick(tileID);
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }


void handleButtonClick(String selectedTileId) async {
 if (isSelected && _textController.text.isNotEmpty) {
    String enteredText = _textController.text;

    try {
      // Attempt to start the script
      var response = await http.post(
        Uri.parse('http://localhost:5000/'), // Adjusted to match the Flask API route
        body: {'start': 'true'},
      );

      if (response.statusCode == 200) {
        print('Python script started successfully');
        // Navigate to the next screen or perform other actions
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionScreen(
              batchId: enteredText,
              tileId:selectedTileId,
            ),
          ),
        );
      } else {
        print('Failed to start Python script: ${response.statusCode}');
        // Show error dialog if execution fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to start Python script'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show error dialog if an error occurs
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while starting the Python script'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
 } else {
    // Show error dialog if conditions are not met
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Please select a tile and enter a Batch ID'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
 }
}
}

