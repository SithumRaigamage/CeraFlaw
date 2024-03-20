import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/DetectionScreen.dart'; // Update with the correct import path

void main() {
  // group of tests
  group('DetectionScreen Widget Tests', () {
    testWidgets('Test Appbar title', (WidgetTester tester) async {
      // build the widget
      await tester.pumpWidget(MaterialApp(
        home: DetectionScreen(batchId: '123', tileId: '456'),
      ));

      // checking if the Appbar title 'Detecting'
      expect(find.text('Detecting'), findsOneWidget);
    });

    testWidgets('Test batch ID and tile ID', (WidgetTester tester) async {
      // build the widget
      await tester.pumpWidget(MaterialApp(
        home: DetectionScreen(batchId: '123', tileId: '456'),
      ));

      // checking that batch ID and tile ID are correctly displayed
      expect(find.text('Batch ID:'), findsOneWidget);
      expect(find.text('123'), findsOneWidget);
      expect(find.text('Tile ID:'), findsOneWidget);
      expect(find.text('456'), findsOneWidget);
    });

    testWidgets('Test count data', (WidgetTester tester) async {
      // build the widget
      await tester.pumpWidget(MaterialApp(
        home: DetectionScreen(batchId: '123', tileId: '456'),
      ));

      // cheaking if all datafields has 'N/A'
      expect(find.text('Edge chippings / Broken corners:'), findsOneWidget);
      expect(find.text('N/A'), findsNWidgets(3)); // three count datafields
      expect(find.text('Surface Defects:'), findsOneWidget);
      expect(find.text('N/A'), findsNWidgets(3));
      expect(find.text('Line / Crack:'), findsOneWidget);
      expect(find.text('N/A'), findsNWidgets(3));
    });

    testWidgets('Test "Back to Main Menu" button', (WidgetTester tester) async {
      // build the widget
      await tester.pumpWidget(MaterialApp(
        home: DetectionScreen(batchId: '123', tileId: '456'),
      ));

      // checking 'Back to Main Menu' button
      expect(find.text('Back to Main Menu'), findsOneWidget);

      // tapping the button and checking functionality
      await tester.tap(find.text('Back to Main Menu'));
      await tester.pump();

      // checking the display dialog
      expect(find.byType(AlertDialog), findsOneWidget);
    });
  });
}
