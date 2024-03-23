import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ManualScreen(),
    );
  }
}

class ManualScreen extends StatefulWidget {
  const ManualScreen({super.key});

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
    String filePath =
        '${directory.path}//README.md'; // Change the file name to README.md
    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            16.0, 24.0, 16.0, 16.0), // Adjust margin top here
        child: Center(
          child: SingleChildScrollView(
            child: _manualContent.isNotEmpty

                // Add your imag

                ? MarkdownBody(data: _manualContent)
                : const CircularProgressIndicator(),

            // Show loading indicator while content is loading
          ), // Show loading indicator while content is loading
        ),
      ),
    );
  }
}
