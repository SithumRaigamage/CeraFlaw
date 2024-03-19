// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/main.dart';
import 'package:ceraflaw/HomeScreen.dart';

void main() {
  testWidgets('Test Main Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CeraFlaw()); // Create an instance of CeraFlaw widget

    // Verify HomeContent widget presence
    expect(find.byType(HomeContent), findsOneWidget);
  });
}
