// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/NotesScreen.dart';

void main() {
  group('NotesScreen tests', () {
    testWidgets('Adding a note', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: NotesScreen()));

      // Fill the text fields with test values.
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');

      // Tap the add button.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the note is added.
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
    });

    testWidgets('Deleting a note', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: NotesScreen()));

      // Fill the text fields with test values.
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');

      // Tap the add button.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Tap the delete button.
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // Verify that the note is deleted.
      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Message'), findsNothing);
    });
  });
}
