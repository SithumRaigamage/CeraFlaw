import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ceraflaw/main.dart';


void main() {
  testWidgets('Test Main Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CeraFlaw()); // Create an instance of CeraFlaw widget

    // Verify container parameters
    expect(find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.constraints is BoxConstraints &&
        widget.constraints!.maxWidth == 500 &&
        widget.constraints!.maxHeight == 500), findsOneWidget);
  });
}


