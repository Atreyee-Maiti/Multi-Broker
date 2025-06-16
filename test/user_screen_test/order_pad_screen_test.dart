import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:broker_app/user_screens/order_pad.dart';
import 'package:broker_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Stock testStock;

  setUp(() {
    testStock = Stock(
        symbol: 'AAPL',
        name: 'Apple Inc',
        price: 150.0,
        change: 1.3,
        changePercent: 0.2);
  });

  Future<void> pumpOrderPad(WidgetTester tester, {required String type}) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => OrderPad(stock: testStock, orderType: type),
            ),
            child: Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets('OrderPad UI and market order placement', (tester) async {
    await pumpOrderPad(tester, type: buy);

    // Verify UI loads
    expect(find.text('BUY AAPL'), findsNWidgets(2));
    expect(find.text('Apple Inc'), findsOneWidget);
    expect(find.text('Current Price: ₹150.00'), findsOneWidget);

    // Test validation: empty quantity
    await tester.tap(find.text('BUY AAPL').last);
    await tester.pump();
    expect(find.text('Please enter quantity'), findsOneWidget);

    // Test validation: invalid quantity
    await tester.enterText(find.byType(TextField).first, '0');
    await tester.tap(find.text('BUY AAPL').last);
    await tester.pump();
    expect(find.text(validQuantity), findsOneWidget);

    // Test valid input for market order
    await tester.enterText(find.byType(TextField).first, '5');
    await tester.tap(find.text('BUY AAPL').last);
    await tester.pumpAndSettle();

    // Confirm SnackBar
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('order placed'), findsOneWidget);
  });

  testWidgets('OrderPad - Close icon works', (tester) async {
    await pumpOrderPad(tester, type: buy);

    // Tap the close icon
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // OrderPad should be closed
    expect(find.text('BUY AAPL'), findsNothing);
  });

  testWidgets('OrderPad - toggling clears error message', (tester) async {
    await pumpOrderPad(tester, type: sell);

    // Trigger validation error
    await tester.tap(find.text('SELL AAPL').last);
    await tester.pump();
    expect(find.text('Please enter quantity'), findsOneWidget);

    // Tap to switch to limit
    await tester.tap(find.text(limit));
    await tester.pump();

    // Error should be cleared
    expect(find.text('Please enter quantity'), findsNothing);
  });
}
