import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/main.dart'; // Import the main.dart file
import 'package:ceraflaw/HomeScreen.dart'; // Import HomeScreen.dart

void main() {
  testWidgets('Test CeraFlaw Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CeraFlaw()); // Create an instance of CeraFlaw widget

    // Verify that MaterialApp, Scaffold, and HomeContent widgets are present.
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(HomeContent), findsOneWidget); // Using HomeContent instead of HomeScreen

    // Verify that the background image is set.
    expect(find.byType(Container), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(Container),
        matching: find.byType(DecorationImage),
      ),
      findsOneWidget,
    );

    // Verify the frame size
    expect(find.byType(Container), findsOneWidget);
    expect(
      tester.getSize(find.byType(Container)),
      Size(500, 500),
    );
  });
}

