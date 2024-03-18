import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/NotesScreen.dart';

void main() {
  group('NotesScreen display tests', () {
    late TextEditingController titleController;
    late TextEditingController messageController;
    late NotesScreen notesScreen;

    setUp(() {
      // initializing controllers and Notescreen instance before tests
      titleController = TextEditingController();
      messageController = TextEditingController();
      notesScreen = NotesScreen();
    });

    testWidgets('Adding new note test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: notesScreen)));

      // simulation (adding note)
      titleController.text = 'Test Title';
      messageController.text = 'Test Message';
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // one note should be added
      expect(notesScreen.notes.length, 1);
    });

    testWidgets('Delete a note test', (WidgetTester tester) async {
      // adding a note to the screen
      notesScreen.notes.add(Note(
        title: 'Test Title',
        message: 'Test Message',
        timestamp: DateTime.now(),
      ));

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: notesScreen)));

      // tapping delete icon
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      // note should be deleted
      expect(notesScreen.notes.length, 0);
    });
  });
}
