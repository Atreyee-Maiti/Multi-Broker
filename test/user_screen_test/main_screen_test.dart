import 'package:broker_app/user_screens/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MainScreen navigation and FAB interactions',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MainScreen(),
    ));

    // Verify initial screen
    expect(find.byType(HoldingsScreen), findsOneWidget);

    // Tap on bottom navigation items and verify screen changes
    await tester.tap(find.byIcon(Icons.account_balance_wallet).last);
    await tester.pump();
    expect(find.byType(HoldingsScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.receipt_long));
    await tester.pump();
    expect(find.byType(OrderbookScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.trending_up));
    await tester.pump();
    expect(find.byType(PositionsScreen), findsOneWidget);

    // Verify FAB interactions
    final fab = find.byType(FloatingActionButton).first;
    expect(fab, findsOneWidget);

    // Tap FAB to expand
    await tester.tap(fab);
    await tester.pump();
    expect(
        find.byType(AnimatedScale), findsNWidgets(2)); // Buy and sell buttons

    // Tap buy and sell buttons
    await tester.tap(find.text('BUY'));
    await tester.pump();
    // Verify buy action

    await tester.tap(find.text('SELL').last);
    await tester.pump();
    // Verify sell action

    // Collapse FAB
    await tester.tap(fab);
    await tester.pump();
    expect(find.byType(AnimatedScale), findsNothing);

    // Drag FAB
    final fabFinder = find.byType(FloatingActionButton);
    await tester.drag(fabFinder, Offset(100, 0)); // Drag right
    await tester.pump();
    // Verify FAB moved

    await tester.drag(fabFinder, Offset(-100, 0)); // Drag left
    await tester.pump();
    // Verify FAB moved

    // Verify FAB snaps to correct side
    await tester.pumpAndSettle();
    // Verify FAB position
  });
}
