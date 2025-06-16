import 'package:broker_app/content_models/order_model_configuration.dart';
import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Order', () {
    test('should create an Order with correct values', () {
      // Arrange
      final stock = Stock(
        symbol: 'TSLA',
        name: 'Tesla Inc.',
        price: 720.50,
        change: 200,
        changePercent: 1.2,
      );
      const type = 'BUY';
      const quantity = 5;
      const price = 725.00;
      const status = 'PENDING';
      final timestamp = DateTime.parse('2025-06-15T10:30:00Z');

      // Act
      final order = Order(
        stock: stock,
        type: type,
        quantity: quantity,
        price: price,
        status: status,
        timestamp: timestamp,
      );

      // Assert
      expect(order.stock, stock);
      expect(order.type, type);
      expect(order.quantity, quantity);
      expect(order.price, price);
      expect(order.status, status);
      expect(order.timestamp, timestamp);
    });
  });
}
