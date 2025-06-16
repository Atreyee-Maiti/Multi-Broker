import 'package:broker_app/content_models/broker_model_configuration.dart';
import 'package:broker_app/user_screens/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginDialog Tests', () {
    late Broker broker;

    setUp(() {
      broker = Broker(name: 'Test Broker', logo: 'TB', color: Colors.blue);
    });

    testWidgets('Displays all UI elements', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginDialog(broker: broker)));
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Shows error dialog when username and password are empty',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginDialog(broker: broker)));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter Password and UserName'), findsOneWidget);
    });

    testWidgets('Shows error dialog when username is empty', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginDialog(broker: broker)));
      await tester.enterText(find.byType(TextField).at(1), 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter UserName'), findsOneWidget);
    });

    testWidgets('Shows error dialog when password is empty', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginDialog(broker: broker)));
      await tester.enterText(find.byType(TextField).at(0), 'username');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text('Please Enter Password'), findsOneWidget);
    });
  });
}
