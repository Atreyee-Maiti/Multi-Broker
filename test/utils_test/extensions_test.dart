import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:broker_app/user_screens/order_pad.dart';
import 'package:broker_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('showOrderPad displays OrderPad modal bottom sheet',
      (WidgetTester tester) async {
    // Arrange: create a test Stock object
    final testStock = Stock(
      symbol: 'AAPL',
      name: 'Apple Inc.',
      price: 150.0,
      change: 2.0,
      changePercent: 1.3,
    );

    // Create a simple app wrapper to provide a Navigator context
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showOrderPad(context, testStock, 'BUY'),
              child: const Text('Open Order Pad'),
            ),
          ),
        ),
      ),
    ));

    // Act: tap the button to trigger showOrderPad
    await tester.tap(find.text('Open Order Pad'));
    await tester.pumpAndSettle();

    // Assert: verify that OrderPad is present
    expect(find.byType(OrderPad), findsOneWidget);
    expect(find.textContaining('BUY'), findsWidgets);
  });
}
