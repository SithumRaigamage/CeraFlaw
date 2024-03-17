import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Note {
  late String title;
  late String message;
  late DateTime timestamp;

  Note({
    required this.title,
    required this.message,
    required this.timestamp,
  });
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesScreen> {
  late List<Note> notes = [];
  late TextEditingController _titleController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _messageController = TextEditingController();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(contents);
      setState(() {
        notes = jsonData
            .map((noteJson) => Note(
                  title: noteJson['title'],
                  message: noteJson['message'],
                  timestamp: DateTime.parse(noteJson['timestamp']),
                ))
            .toList();
      });
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> _saveNotes() async {
    try {
      final file = await _localFile;
      List<Map<String, dynamic>> jsonData = notes
          .map((note) => {
                'title': note.title,
                'message': note.message,
                'timestamp': note.timestamp.toIso8601String(),
              })
          .toList();
      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      print('Error saving notes: $e');
    }
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/GitHub/CeraFlaw/notes.json';
    print('File path: $filePath');
    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_messageController.text.isEmpty ||
                        _titleController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Fields are empty'),
                          content:
                              Text('Please fill title and message fields.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      setState(() {
                        final newNote = Note(
                          title: _titleController.text,
                          message: _messageController.text,
                          timestamp: DateTime.now(),
                        );
                        notes.add(newNote);
                        _saveNotes();
                        _titleController.clear();
                        _messageController.clear();
                      });
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.message),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        notes.removeAt(index);
                        _saveNotes();
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
