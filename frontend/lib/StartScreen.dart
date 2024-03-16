import 'package:flutter/material.dart';
import 'detectionScreen.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
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
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: buildImageTile(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
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
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/marbletile.jpeg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text('E001'),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldAndButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter Batch ID',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: ElevatedButton(
            onPressed: () {
                handleButtonClick();
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }


  void handleButtonClick() async {
  if (isSelected && _textController.text.isNotEmpty) {
    String enteredText = _textController.text;
    print('Tile ID: E001, Batch ID: $enteredText');

    try {
      // Navigate to the next screen or perform other actions
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionScreen(
              batchId: enteredText,
            ),
          ),
        );
      var response = await http.post(
        Uri.parse('http://192.168.1.166:5000/run-script'),  //change the http link to the address you recieve from the server but always keep /run-script
        body: {'start': 'true'},
      );
      if (response.statusCode == 200) {
        print('Python script executed successfully');
      } else {
        print('Failed to execute Python script: ${response.statusCode}');
        // Show error dialog if execution fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to execute Python script'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
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
          title: Text('Error'),
          content: Text('An error occurred while executing the Python script'),
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
    // Show error dialog if conditions are not met
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please select a tile and enter a Batch ID'),
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
}

