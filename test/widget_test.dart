// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_page/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomePage renders and tap changes background color', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Hello there'), findsOneWidget);

    final decoratedBoxFinder = find.byType(DecoratedBox);
    final DecoratedBox decoratedBoxBefore = tester.widget<DecoratedBox>(
      decoratedBoxFinder,
    );
    final Color? initialColor =
        (decoratedBoxBefore.decoration as BoxDecoration).color;

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    final DecoratedBox decoratedBoxAfter = tester.widget<DecoratedBox>(
      decoratedBoxFinder,
    );
    final Color? newColor =
        (decoratedBoxAfter.decoration as BoxDecoration).color;

    expect(newColor, isNot(equals(initialColor)));
  });
}
