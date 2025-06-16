import 'index.dart';

class Position {
  final Stock stock;
  final String type;
  final int quantity;
  final double entryPrice;
  final double pnl;

  Position({
    required this.stock,
    required this.type,
    required this.quantity,
    required this.entryPrice,
    required this.pnl,
  });
}
