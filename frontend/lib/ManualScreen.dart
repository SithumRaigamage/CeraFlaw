
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ManualScreen extends StatefulWidget {
  @override
  _ManualScreenState createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  final TextEditingController _notesEditingController = TextEditingController();
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'notes.txt');
      final file = File(filePath);
      if (await file.exists()) {
        setState(() {
          _notes = file.readAsStringSync();
        });
      }
    } catch (e) {
      print("Failed to load notes: $e");
    }
  }

  Future<void> _updateNotes() async {
    setState(() {
      _notes += '\n' + _notesEditingController.text;
      _notesEditingController.clear(); // Clear the input field after appending
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'notes.txt');
      final file = File(filePath);
      await file.writeAsString(_notes, mode: FileMode.append);
    } catch (e) {
      print("Failed to update notes: $e");
    }
  }

  void _deleteNotes() {
    setState(() {
      _notes = '';
      _notesEditingController.clear();
    });
  }

  void _deleteFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'notes.txt');
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        setState(() {
          _notes = ''; // Clear the notes field after deleting the file
        });
      }
    } catch (e) {
      print("Failed to delete file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteNotes();
              _deleteFile(); // Call the function to delete the file
            },
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Notes:',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _notes,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _notesEditingController,
              decoration: InputDecoration(
                labelText: 'Enter notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateNotes, // Call _updateNotes when the button is pressed
        tooltip: 'Save',
        child: Icon(Icons.save),
      ),
    );
  }
}
