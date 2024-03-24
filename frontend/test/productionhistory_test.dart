import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/ProductionHistoryScreen.dart';

void main() {
  testWidgets('Testing Appbar title', (WidgetTester tester) async {
    // build widget
    await tester.pumpWidget(const MaterialApp(
      home: ProductionHistoryScreen(),
    ));

    // checking Appbar title is 'Production History'
    expect(find.text('Production History'), findsOneWidget);
  });

  testWidgets('Testing if Scaffold is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ProductionHistoryScreen(),
    ));

    // checking if Scaffold is present
    expect(find.byType(Scaffold), findsOneWidget);
  });

  // data table removed

  // testWidgets('Test if DataTable is present', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(
  //     home: ProductionHistoryScreen(),
  //   ));

  //   // checking if DataTable is present
  //   expect(find.byType(DataTable), findsOneWidget);
  // });
  testWidgets('Test if DataTable is not present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ProductionHistoryScreen(),
    ));

    // checking if DataTable is not present
    expect(find.byType(DataTable), findsNothing);
  });
  

  testWidgets('Test if CircularProgressIndicator is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ProductionHistoryScreen(),
    ));

    // checking if CircularProgressIndicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}