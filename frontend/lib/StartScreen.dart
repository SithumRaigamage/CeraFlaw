import 'package:flutter/material.dart';
import 'detectionScreen.dart';
import 'package:http/http.dart' as http;
//import 'tile.dart';
/*
void main() {
  runApp(StartScreen());
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Grid and Flow Layout',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid and Flow Layout'),
          // Adding an arrow button for navigation back to the previous screen
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // No redirection when '2 by 2 ceramic tile' is pressed
                // Only display the message on DetectionScreen if a batch ID is entered and submitted
                _navigateToDetectionScreen(context, '2 by 2 ceramic tile was selected');
              },
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    '2 by 2 ceramic tile',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BatchIdForm(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetectionScreen(BuildContext context, String message) {
    // Check if the batch ID is not empty before navigating to DetectionScreen
    String batchId = BatchIdForm.of(context).batchId;
    if (batchId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectionScreen(batchId: '$batchId\n$message'),
        ),
      );
    }
  }
}

class BatchIdForm extends StatefulWidget {
  @override
  _BatchIdFormState createState() => _BatchIdFormState();

  static _BatchIdFormState of(BuildContext context) {
    final _BatchIdFormState? result = context.findAncestorStateOfType<_BatchIdFormState>();
    assert(result != null, 'No BatchIdForm found in context');
    return result!;
  }
}

class _BatchIdFormState extends State<BatchIdForm> {
  late TextEditingController _batchIdController;

  @override
  void initState() {
    super.initState();
    _batchIdController = TextEditingController();
  }

  @override
  void dispose() {
    _batchIdController.dispose();
    super.dispose();
  }

  String get batchId => _batchIdController.text.trim();

  void _handleSubmit(BuildContext context) {
    String batchId = _batchIdController.text.trim();

    if (batchId.isNotEmpty) {
      // Navigate to DetectionScreen only if batch ID is not empty
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetectionScreen(batchId: batchId),
        ),
      );
    } else {
      // Show popup panel if batchId field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Empty Batch ID'),
          content: Text('Please enter characters with numbers for Batch ID.'),
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _batchIdController,
            decoration: InputDecoration(
              labelText: 'Batch Id',
              border: OutlineInputBorder(),
            ),
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
    );
  }
}
*/

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
              if (isSelected && _textController.text.isNotEmpty) {
                // Conditions met, proceed as before
                String enteredText = _textController.text;
                print('Tile ID: E001, Batch ID: $enteredText');
                // Navigate to the next screen or perform other actions
                handleButtonClick();
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetectionScreen(
                      batchId: enteredText
                      // Pass data (optional) to detectionScreen if needed
                      //selectedTileId: 'E001',
                      //enteredBatchId: enteredText,
                    ),
                  ),
                );
              } else {
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
      var response = await http.get(Uri.parse('http://127.0.0.1:5000/run-script'));
      if (response.statusCode == 200) {
        print('Python script executed successfully');
        // Navigate to the next screen or perform other actions
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectionScreen(
              batchId: enteredText,
            ),
          ),
        );
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

