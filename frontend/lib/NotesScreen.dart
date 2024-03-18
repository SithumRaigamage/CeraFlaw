import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

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
<<<<<<< HEAD
  late List<Note> notes = [];
=======
  const NotesScreen({super.key});

>>>>>>> front_end
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesScreen> {
  
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
<<<<<<< HEAD
        widget.notes = jsonData.map((noteJson) => Note(
          title: noteJson['title'],
          message: noteJson['message'],
          timestamp: DateTime.parse(noteJson['timestamp']),
        )).toList();
=======
        notes = jsonData
            .map((noteJson) => Note(
                  title: noteJson['title'],
                  message: noteJson['message'],
                  timestamp: DateTime.parse(noteJson['timestamp']),
                ))
            .toList();
>>>>>>> front_end
      });
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> _saveNotes() async {
    try {
      final file = await _localFile;
      List<Map<String, dynamic>> jsonData = widget.notes
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
    // Use Directory.current to get the current working directory
    final directory = Directory.current;
    // Specify the file name and path relative to the current directory
<<<<<<< HEAD
    String filePath = '${directory.path}/notes.json';
=======
    String filePath = '${directory.path}\\notes.json';
>>>>>>> front_end
    print('File path: $filePath');
    return File(filePath);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
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
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_messageController.text.isEmpty ||
                        _titleController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Fields are empty'),
                          content:
                              const Text('Please fill title and message fields.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
<<<<<<< HEAD
                      widget.notes.add(newNote);
                      _saveNotes();
                      _titleController.clear();
                      _messageController.clear();
                    });
=======
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
>>>>>>> front_end
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.notes.length,
              itemBuilder: (context, index) {
                final note = widget.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.message),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.notes.removeAt(index);
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
