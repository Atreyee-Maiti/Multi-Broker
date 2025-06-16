import 'package:broker_app/content_models/holding_model_configuration.dart';
import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Holding', () {
    test('should create Holding instance with correct properties', () {
      // Arrange
      final stock = Stock(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: 180.50,
        change: 900,
        changePercent: 0.9,
      );
      const quantity = 10;
      const avgPrice = 150.0;
      const currentValue = 1805.0;
      const pnl = 305.0;

      // Act
      final holding = Holding(
        stock: stock,
        quantity: quantity,
        avgPrice: avgPrice,
        currentValue: currentValue,
        pnl: pnl,
      );

      // Assert
      expect(holding.stock, stock);
      expect(holding.quantity, quantity);
      expect(holding.avgPrice, avgPrice);
      expect(holding.currentValue, currentValue);
      expect(holding.pnl, pnl);
    });
  });
}
