import 'package:broker_app/user_screens/order_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OrderbookScreen', () {
    testWidgets('Displays order list when orders are present',
        (WidgetTester tester) async {
      // Override the mock data with sample data

      await tester.pumpWidget(MaterialApp(home: OrderbookScreen()));

      expect(find.text('Unrealized P&L'), findsOneWidget);
      expect(find.text('Realized P&L'), findsOneWidget);
      expect(find.text('AAPL'), findsOneWidget);

      // Tap on order to trigger InkWell
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle(); // Ensure onTap executes
    });
  });
}
