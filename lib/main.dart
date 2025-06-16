import 'package:flutter/material.dart';
import 'user_screens/index.dart';

void main() {
  runApp(TradingApp());
}

class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muti-Trading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BrokerSelectionScreen(),
    );
  }
}
