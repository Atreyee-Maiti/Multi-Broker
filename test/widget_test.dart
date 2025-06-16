// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:broker_app/main.dart';
import 'package:broker_app/user_screens/broker_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TradingApp builds MaterialApp with correct properties',
      (WidgetTester tester) async {
    // Pump the TradingApp widget
    await tester.pumpWidget(const TradingApp());

    // Verify that MaterialApp is present
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify the title of MaterialApp
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.title, 'Muti-Trading');

    // Verify the home widget is BrokerSelectionScreen
    expect(find.byType(BrokerSelectionScreen), findsOneWidget);
  });
}
