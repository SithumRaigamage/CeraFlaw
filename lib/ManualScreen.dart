
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';



class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paragraph Sentences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParagraphSentencesScreen(),
    );
  }
}

class ParagraphSentencesScreen extends StatefulWidget {
  @override
  _ParagraphSentencesScreenState createState() =>
      _ParagraphSentencesScreenState();
}

class _ParagraphSentencesScreenState extends State<ParagraphSentencesScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Paragraph Sentences'),
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
    );
  }
}
