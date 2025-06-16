import 'package:broker_app/user_screens/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NothingFoundWidget default UI test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NothingFoundWidget(),
        ),
      ),
    );

    // Default icon is Icons.search_off
    expect(find.byIcon(Icons.search_off), findsOneWidget);

    // Default title and message
    expect(find.text('Nothing Found'), findsOneWidget);
    expect(find.text("We couldn’t find any results."), findsOneWidget);
  });

  testWidgets('NothingFoundWidget custom values and retry button test',
      (WidgetTester tester) async {
    bool retryTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NothingFoundWidget(
            title: 'Custom Title',
            message: 'Custom message here.',
            icon: Icons.error,
            onRetry: () {
              retryTapped = true;
            },
          ),
        ),
      ),
    );

    // Custom icon
    expect(find.byIcon(Icons.error), findsOneWidget);

    // Custom title and message
    expect(find.text('Custom Title'), findsOneWidget);
    expect(find.text('Custom message here.'), findsOneWidget);

    // Retry button should be shown

    expect(find.text('Retry'), findsOneWidget);

    // Tap retry button triggers onRetry callback
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(retryTapped, isTrue);
  });
}
