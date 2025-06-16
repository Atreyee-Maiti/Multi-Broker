import 'package:broker_app/content_models/stock_model_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stock', () {
    test('should create a Stock object with correct values', () {
      // Arrange
      final stock = Stock(
        symbol: 'HDFCBANK',
        name: 'HDFC Bank',
        price: 1645.25,
        change: -10.75,
        changePercent: -0.65,
      );

      // Assert
      expect(stock.symbol, 'HDFCBANK');
      expect(stock.name, 'HDFC Bank');
      expect(stock.price, 1645.25);
      expect(stock.change, -10.75);
      expect(stock.changePercent, -0.65);
    });
  });
}
