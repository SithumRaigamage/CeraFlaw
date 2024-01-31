import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesApp(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1B1B1E),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Color(0xFFF3F3F4), fontSize: 16.0),
          headline1: TextStyle(
            color: Color(0xFFF3F3F4),
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Color(0xFF1B1B1E),
            backgroundColor: Color(0xFFF3F3F4),
          ),
        ),
      ),
    );
  }
}

class NotesApp extends StatefulWidget {
  @override
  _NotesAppState createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  List<Map<String, String>> notes = [];

  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController = TextEditingController();
        TextEditingController messageController = TextEditingController();

        return AlertDialog(
          title: Text("Add Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'Message'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notes.add({
                    'title': titleController.text,
                    'message': messageController.text,
                  });
                });
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notes[index]['title'] ?? '',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        notes[index]['message'] ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Timestamp', // Replace with actual timestamp
                        style: TextStyle(color: Color(0xFF7E7F83)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteNote(index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}