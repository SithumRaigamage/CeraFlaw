import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ManualScreen extends StatefulWidget {
  @override
  _ManualScreenState createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _paragraph = '';

  @override
  void initState() {
    super.initState();
    _loadParagraph();
  }

  void _loadParagraph() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/paragraph.txt');
      if (await file.exists()) {
        setState(() {
          _paragraph = file.readAsStringSync();
        });
      }
    } catch (e) {
      print("Failed to load paragraph: $e");
    }
  }

  void _updateParagraph() async {
    setState(() {
      _paragraph = _textEditingController.text;
    });

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/paragraph.txt');
    await file.writeAsString(_paragraph);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press event
        Navigator.pop(context);
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Paragraph Sentences'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _updateParagraph,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _paragraph,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter a sentence',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (text) {
                  _updateParagraph();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
