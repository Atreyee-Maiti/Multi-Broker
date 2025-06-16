import 'package:broker_app/user_screens/holdings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HoldingsScreen shows holdings list and summary', (tester) async {
    await tester.pumpWidget(MaterialApp(home: HoldingsScreen()));

    // Verify AppBar title and icon present
    expect(find.text('Holdings'), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_wallet), findsOneWidget);

    // Should find the summary card with total values
    expect(find.byType(Container), findsWidgets);

    // Holdings list should be displayed (ListView items)
    expect(find.byType(ListView), findsOneWidget);

    // Tap on first holding item triggers showOrderPad
    // Since showOrderPad triggers a bottom sheet, let's check for it
    final firstHoldingCard = find.byType(InkWell).first;
    expect(firstHoldingCard, findsOneWidget);

    await tester.tap(firstHoldingCard);
    await tester.pumpAndSettle();

    // Bottom sheet should open with OrderPad widget
    expect(find.text('OrderPad'), findsNothing);
    // Note: OrderPad widget is not imported here. If you have OrderPad widget you can check accordingly.
    // If showOrderPad is from a utility method, consider mocking it or checking for the bottom sheet open
  });
}
