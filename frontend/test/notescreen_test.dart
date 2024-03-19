import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/NotesScreen.dart';

void main() {
  group('NotesScreen display tests', () {
    late TextEditingController titleController;
    late TextEditingController messageController;
    late NotesScreenState notesScreen;

    setUp(() {
      // initializing controllers and Notescreen instance before tests
      titleController = TextEditingController();
      messageController = TextEditingController();
      notesScreen = NotesScreenState(); // Creating an instance directly
    });

    testWidgets('Adding new note test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return notesScreen.widget;
            },
          ),
        ),
      ));
      // simulation (adding note)
      titleController.text = 'Test Title';
      messageController.text = 'Test Message';
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // one note should be added
      expect(notesScreen.getNotes().length, 1);
    });

    testWidgets('Delete a note test', (WidgetTester tester) async {
      // adding a note to the screen
      notesScreen.notes.add(Note(
        title: 'Test Title',
        message: 'Test Message',
        timestamp: DateTime.now(),
      ));

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return notesScreen.widget;
            },
          ),
        ),
      ));

      // tapping delete icon
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      // note should be deleted
      expect(notesScreen.getNotes().length, 0);
    });
  });
}
