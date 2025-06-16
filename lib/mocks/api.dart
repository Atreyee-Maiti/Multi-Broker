import 'package:flutter/material.dart';

import '../content_models/index.dart';

class MockAPI {
  static List<Broker> getBrokers() => [
        Broker(name: 'Zerodha', logo: 'Z', color: Colors.blue),
        Broker(name: 'Angel One', logo: 'A', color: Colors.red),
        Broker(name: 'Upstox', logo: 'U', color: Colors.purple),
        Broker(name: 'ICICI Direct', logo: 'I', color: Colors.orange),
        Broker(name: 'HDFC Securities', logo: 'H', color: Colors.green),
        Broker(name: 'Groww', logo: 'G', color: Colors.lightGreen),
        Broker(
            name: 'SBI Capital Markets',
            logo: 'S',
            color: Colors.blue.shade900),
        Broker(name: 'Dhann', logo: 'D', color: Color(0xFF556B2F)),
        Broker(name: 'Motilal Oswal', logo: 'M', color: Color(0xFFB8860B)),
        Broker(name: 'Kotak Securities', logo: 'K', color: Color(0xFFB71C1C)),
      ];
  static List<Holding> getHoldings() => [
        Holding(
          stock: Stock(
              symbol: 'AAPL',
              name: 'Apple Inc.',
              price: 150.25,
              change: 2.50,
              changePercent: 1.69),
          quantity: 10,
          avgPrice: 145.00,
          currentValue: 1502.50,
          pnl: 52.50,
        ),
        Holding(
          stock: Stock(
              symbol: 'GOOGL',
              name: 'Alphabet Inc.',
              price: 2750.80,
              change: -15.20,
              changePercent: -0.55),
          quantity: 2,
          avgPrice: 2800.00,
          currentValue: 5501.60,
          pnl: -98.40,
        ),
        Holding(
          stock: Stock(
              symbol: 'GS',
              name: 'GoldManSac',
              price: 1500.15,
              change: 6.75,
              changePercent: 3.05),
          quantity: 8,
          avgPrice: 1600.00,
          currentValue: 6525.75,
          pnl: 15.35,
        ),
        Holding(
          stock: Stock(
              symbol: 'JPM',
              name: 'JP Morgans',
              price: 680,
              change: 2.1,
              changePercent: 3.8),
          quantity: 1,
          avgPrice: 700.00,
          currentValue: 900.75,
          pnl: 15.95,
        ),
        Holding(
          stock: Stock(
              symbol: 'FB',
              name: 'Meta',
              price: 30.15,
              change: -2.1,
              changePercent: -1.3),
          quantity: 4,
          avgPrice: 30.00,
          currentValue: 325.75,
          pnl: 05.75,
        ),
        Holding(
          stock: Stock(
              symbol: 'MSFT',
              name: 'Microsoft Corp.',
              price: 305.15,
              change: 3.75,
              changePercent: 1.24),
          quantity: 5,
          avgPrice: 300.00,
          currentValue: 1525.75,
          pnl: 25.75,
        ),
        Holding(
          stock: Stock(
              symbol: 'TCS',
              name: 'Tata Consultancy Services',
              price: 126.15,
              change: -1.75,
              changePercent: -0.3),
          quantity: 15,
          avgPrice: 100.00,
          currentValue: 2525.75,
          pnl: 85.75,
        ),
        Holding(
          stock: Stock(
              symbol: 'TP',
              name: 'TATA POWER',
              price: 1305.15,
              change: 4.75,
              changePercent: 3.24),
          quantity: 3,
          avgPrice: 1300.00,
          currentValue: 1725.75,
          pnl: 45.75,
        ),
      ];
  static List<Position> getPositions() => [
        Position(
          stock: Stock(
              symbol: 'PRIME',
              name: 'Amazon Inc.',
              price: 400.99,
              change: 2.13,
              changePercent: 2.66),
          type: 'LONG',
          quantity: 4,
          entryPrice: 496.00,
          pnl: 16.10,
        ),
        Position(
          stock: Stock(
              symbol: 'BlackBerry',
              name: 'BlackBerry Inc.',
              price: 127.45,
              change: -2.12,
              changePercent: -1.05),
          type: 'SHORT',
          quantity: 6,
          entryPrice: 600.00,
          pnl: 05.10,
        ),
        Position(
          stock: Stock(
              symbol: 'Fit',
              name: 'BoxFit Lim.',
              price: 687.45,
              change: -9.12,
              changePercent: -3.05),
          type: 'SHORT',
          quantity: 1,
          entryPrice: 500.00,
          pnl: 12.10,
        ),
        Position(
          stock: Stock(
              symbol: 'Milton',
              name: 'Milton Inc.',
              price: 222.45,
              change: 1.12,
              changePercent: 0.05),
          type: 'LONG',
          quantity: 2,
          entryPrice: 95.00,
          pnl: 1.10,
        ),
        Position(
          stock: Stock(
              symbol: 'NFLX',
              name: 'Netflix Inc.',
              price: 387.45,
              change: -8.12,
              changePercent: -2.05),
          type: 'SHORT',
          quantity: 2,
          entryPrice: 395.00,
          pnl: 15.10,
        ),
        Position(
          stock: Stock(
              symbol: 'TSLA',
              name: 'Tesla Inc.',
              price: 245.67,
              change: 5.23,
              changePercent: 2.17),
          type: 'LONG',
          quantity: 3,
          entryPrice: 240.00,
          pnl: 17.01,
        ),
        Position(
          stock: Stock(
              symbol: 'Samsung',
              name: 'Samsung Inc.',
              price: 187.45,
              change: 2.12,
              changePercent: 1.05),
          type: 'LONG',
          quantity: 1,
          entryPrice: 295.00,
          pnl: 10.10,
        ),
      ];
  static List<Order> getOrders() => [
        Order(
          stock: Stock(
              symbol: 'AAPL',
              name: 'Apple Inc.',
              price: 150.25,
              change: 2.50,
              changePercent: 1.69),
          type: 'BUY',
          quantity: 10,
          price: 148.00,
          status: 'EXECUTED',
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
        ),
        Order(
          stock: Stock(
              symbol: 'GOOGL',
              name: 'Alphabet Inc.',
              price: 2750.80,
              change: -15.20,
              changePercent: -0.55),
          type: 'SELL',
          quantity: 1,
          price: 2800.00,
          status: 'PENDING',
          timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        ),
      ];
}
