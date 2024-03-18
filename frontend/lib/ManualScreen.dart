
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManualScreen(),
    );
  }
}

class ManualScreen extends StatefulWidget {
  @override
  _ManualScreenState createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  String _manualContent = "";

  @override
  void initState() {
    super.initState();
    loadManual();
  }

  Future<void> loadManual() async {
    try {
      final file = await _localFile;
      String manualContent = await file.readAsString();
      setState(() {
        _manualContent = manualContent;
      });
    } catch (e) {
      print("Error loading manual: $e");
    }
  }

  Future<File> get _localFile async {
    final directory = Directory.current;
    String filePath = '${directory.path}//README.md'; // Change the file name to README.md
    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0), // Adjust margin top here
        child: Center(
          child: SingleChildScrollView(
            child: _manualContent.isNotEmpty
                ? MarkdownBody(data: _manualContent)
                : CircularProgressIndicator(), // Show loading indicator while content is loading
          ),
        ),
      ),
    );
  }
}
