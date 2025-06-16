import 'index.dart';

class Holding {
  final Stock stock;
  final int quantity;
  final double avgPrice;
  final double currentValue;
  final double pnl;

  Holding({
    required this.stock,
    required this.quantity,
    required this.avgPrice,
    required this.currentValue,
    required this.pnl,
  });
}
