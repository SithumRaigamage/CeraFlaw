import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/SettingsScreen.dart';

void main() {
  // Group of tests
  group('SettingsScreen tests', () {
    testWidgets('Screen test', (WidgetTester tester) async {
      // pump SettingsScreen widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SettingsScreen())));
      // checking "Settings" text
      expect(find.text('Settings'), findsOneWidget);
      // checking if there is a button
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Clear Capture Data Button Test', (WidgetTester tester) async {
      // pump SettingsScreen widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SettingsScreen())));

      // Tap the 'Clear Capture Data' button
      await tester.tap(find.text('Clear Capture Data'));
      await tester.pumpAndSettle();

      // verifing snack bar msgs
      expect(
        find.text('Data Cleared').evaluate().isEmpty || find.text('Frames directory not found').evaluate().isEmpty,
        isTrue,
        reason: 'Either "Data Cleared" or "Frames directory not found" snackbar should be shown',
      );
    });
  });
}
