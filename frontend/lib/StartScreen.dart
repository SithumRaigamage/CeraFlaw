
import 'package:flutter/material.dart';
import 'detectionScreen.dart';

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
