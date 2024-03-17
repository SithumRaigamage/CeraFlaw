import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/HomeScreen.dart';
// import 'package:ceraflaw/StartScreen.dart';
// import 'package:ceraflaw/ManualScreen.dart';
// import 'package:ceraflaw/ProductionHistoryScreen.dart';
// import 'package:ceraflaw/SettingsScreen.dart';
// import 'package:ceraflaw/NotesScreen.dart';

void main() {
  testWidgets('Test CeraFlaw Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: HomeContent()))); // Create an instance of CeraFlaw widget

    // check for logo and icons on widget
    expect(find.byType(Image), findsNWidgets(7));

    // check for all buttons (6)
    expect(find.byType(GestureDetector), findsNWidgets(6));

    // // navigation test (tap on each button)
    // await tester.tap(find.text('Start'));
    // await tester.pumpAndSettle();
    // expect(find.byType(StartScreen), findsOneWidget);

    // await tester.tap(find.text('Manual'));
    // await tester.pumpAndSettle();
    // expect(find.byType(ManualScreen), findsOneWidget);

    // await tester.tap(find.text('Production History'));
    // await tester.pumpAndSettle();
    // expect(find.byType(ProductionHistoryScreen), findsOneWidget);

    // await tester.tap(find.text('Settings'));
    // await tester.pumpAndSettle();
    // expect(find.byType(SettingsScreen), findsOneWidget);

    // await tester.tap(find.text('Notes'));
    // await tester.pumpAndSettle();
    // expect(find.byType(NotesScreen), findsOneWidget);
  });
}


