import 'package:broker_app/user_screens/broker_selection_screen.dart';
import 'package:broker_app/user_screens/login_screen.dart';
import 'package:broker_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BrokerSelectionScreen UI and interaction test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: BrokerSelectionScreen()),
    );

    // Verify AppBar contains the Icon
    expect(find.byIcon(Icons.group), findsOneWidget);

    // Verify AppBar title text (selectYourBroker constant)
    expect(find.text(selectYourBroker), findsOneWidget);

    // Verify "chooseBroker" text is shown in the body
    expect(find.text(chooseBroker), findsOneWidget);

    // Verify GridView is present
    expect(find.byType(GridView), findsOneWidget);

    final keyFinder = find.byKey(const Key('BrokerLogo')).first;
    expect(keyFinder, findsOneWidget);
    // Tap the first broker tile to trigger dialog

    expect(keyFinder, findsOneWidget);

    await tester.tap(keyFinder);
    await tester.pumpAndSettle();

    // Verify LoginDialog is shown after tapping a broker
    expect(find.byType(LoginDialog), findsOneWidget);
  });
}
