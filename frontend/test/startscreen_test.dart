import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/StartScreen.dart';


void main() {
  testWidgets('StartScreen Test', (WidgetTester tester) async {
    // build StartScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: StartScreen(),
    ));
    // checking if the ui elements exsists
    expect(find.text('Select Tile'), findsOneWidget);
    expect(find.text('Enter Batch ID'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    expect(find.text('T001'), findsOneWidget); // tileID
    expect(find.byType(TextField), findsOneWidget); // TextField
    expect(find.byType(ElevatedButton), findsOneWidget); // ElevatedButton
  });

  testWidgets('Button functionality', (WidgetTester tester) async {
    // build StartScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: StartScreen(),
    ));

    // tapping the submit button without selecting a tile or entering a batch ID
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // error msg
    expect(find.text('Please select a tile and enter a Batch ID'), findsOneWidget);

    // selecting a tile
    await tester.tap(find.byWidgetPredicate((widget) => widget is GestureDetector && widget.key == const ValueKey('tile')));
    await tester.pump();

    // entering a batch ID
    await tester.enterText(find.byType(TextField), 'Batch123');
    await tester.pump();

    // tapping the submit button again
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // nav to DetectionScreen
    // expect(find.text('Batch ID: Batch123'), findsOneWidget);
  });
}
