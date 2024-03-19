import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/NotesScreen.dart';

void main() {
  group('NotesScreen tests', () {
    testWidgets('Adding a note', (WidgetTester tester) async {
      // build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: NotesScreen()));

      // filling the text fields with test values.
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');

      // tapping the add button.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // checking if notes got added
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
    });

    testWidgets('Deleting a note', (WidgetTester tester) async {
      // build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: NotesScreen()));

      // fill the text fields with test values.
      await tester.enterText(find.byType(TextField).first, 'Test Title');
      await tester.enterText(find.byType(TextField).last, 'Test Message');

      // tapping the add button.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // tapping the delete button.
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // check if notes get delete
      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Message'), findsNothing);
    });
  });
}
