import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/ManualScreen.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  // test loading indicator is displayed before content is loaded
  testWidgets('Testing loading indicator', (WidgetTester tester) async {
    // pump the widget
    await tester.pumpWidget(MaterialApp(
      home: ManualScreen(),
    ));

    // checking if CircularProgressIndicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // checking that the content is not loaded yet
    expect(find.byType(Markdown), findsNothing);
  });

  // test the app bar title is 'Manual'
  testWidgets('Testing app bar title', (WidgetTester tester) async {
    // pump the widget
    await tester.pumpWidget(MaterialApp(
      home: ManualScreen(),
    ));

    // checking if the app bar title is 'Manual'
    expect(find.text('Manual'), findsOneWidget);
  });

  testWidgets('Test if Scaffold is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ManualScreen(),
    ));

    // checking if Scaffold is present
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Test if SingleChildScrollView is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ManualScreen(),
    ));

    // checking if SingleChildScrollView is present
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  // test padding widget and padding values
  testWidgets('Test if Padding is present', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ManualScreen(),
      ));

      // checking padding is present with the specified padding values
      expect(find.byWidgetPredicate(
        (Widget widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      ), findsOneWidget);
  });
}
