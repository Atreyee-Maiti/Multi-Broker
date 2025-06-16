import 'package:broker_app/user_screens/positions_screen.dart';
import 'package:broker_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PositionsScreen', () {
    testWidgets('renders UI with positions and taps on a position',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: PositionsScreen()),
      );

      // Verify AppBar & Title
      expect(find.text(positions), findsOneWidget);
      expect(find.byIcon(Icons.trending_up).first, findsOneWidget);

      // Verify P&L card renders
      expect(find.text(totalPL), findsOneWidget);

      // Tap the first position (LONG, triggers showOrderPad with SELL)
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
    });
  });
}