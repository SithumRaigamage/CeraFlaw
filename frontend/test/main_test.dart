// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/main.dart';
import 'package:ceraflaw/HomeScreen.dart';

void main() {
  testWidgets('Test CeraFlaw Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CeraFlaw()); // Create an instance of CeraFlaw widget

    // check availability Homecontent widget
    expect(find.byType(HomeContent), findsOneWidget);
  });
}