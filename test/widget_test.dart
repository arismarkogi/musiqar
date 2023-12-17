// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Swipe right should navigate to SwipeRightPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the initial page is the HomePage
    expect(find.text('Home Page'), findsOneWidget);

    // Simulate a swipe right gesture (you might need to adjust the coordinates)
    await tester.dragFrom(tester.getTopLeft(find.text('Home Page')), Offset(300, 0));
    await tester.pump();

    // Verify that the page is now the SwipeRightPage
    expect(find.text('Swipe Right Page'), findsOneWidget);
  });
}
