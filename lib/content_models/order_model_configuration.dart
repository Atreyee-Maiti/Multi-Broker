import 'index.dart';

class Order {
  final Stock stock;
  final String type;
  final int quantity;
  final double price;
  final String status;
  final DateTime timestamp;

  Order({
    required this.stock,
    required this.type,
    required this.quantity,
    required this.price,
    required this.status,
    required this.timestamp,
  });
}
