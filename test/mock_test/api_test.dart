import 'package:broker_app/mocks/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('MockAPI Tests', () {
    test('getBrokers returns a list of 10 brokers with expected values', () {
      final brokers = MockAPI.getBrokers();
      expect(brokers.length, 10);
      expect(brokers.first.name, 'Zerodha');
      expect(brokers.last.logo, 'K');
      expect(brokers[2].color, Colors.purple);
    });

    test('getHoldings returns a non-empty list of Holding objects', () {
      final holdings = MockAPI.getHoldings();
      expect(holdings.length, 8);
      expect(holdings[0].stock.symbol, 'AAPL');
      expect(holdings[1].pnl, closeTo(-98.40, 0.01));
      expect(holdings[5].stock.name, 'Microsoft Corp.');
    });

    test('getPositions returns a non-empty list of Position objects', () {
      final positions = MockAPI.getPositions();
      expect(positions.length, 7);
      expect(positions[0].type, 'LONG');
      expect(positions[1].type, 'SHORT');
      expect(positions[3].stock.symbol, 'Milton');
      expect(positions[4].pnl, greaterThan(0));
    });

    test('getOrders returns list with correct types and recent timestamps', () {
      final orders = MockAPI.getOrders();
      expect(orders.length, 2);
      expect(orders[0].status, 'EXECUTED');
      expect(orders[1].type, 'SELL');
      expect(orders[1].timestamp.isBefore(DateTime.now()), isTrue);
    });
  });
}
