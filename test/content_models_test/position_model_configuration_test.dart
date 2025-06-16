import 'package:broker_app/content_models/position_model_configuration.dart';
import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Position', () {
    test('should create a Position with correct values', () {
      // Arrange
      final stock = Stock(
        symbol: 'INFY',
        name: 'Infosys Ltd.',
        price: 1450.00,
        change: 100,
        changePercent: 0.1,
      );
      const type = 'LONG';
      const quantity = 20;
      const entryPrice = 1400.00;
      const pnl = 1000.00;

      // Act
      final position = Position(
        stock: stock,
        type: type,
        quantity: quantity,
        entryPrice: entryPrice,
        pnl: pnl,
      );

      // Assert
      expect(position.stock, stock);
      expect(position.type, type);
      expect(position.quantity, quantity);
      expect(position.entryPrice, entryPrice);
      expect(position.pnl, pnl);
    });
  });
}
