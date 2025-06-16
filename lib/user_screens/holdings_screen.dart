import '../mocks/api.dart';
import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';
import 'empty_screen.dart';

class HoldingsScreen extends StatelessWidget {
  final List<Holding> holdings = MockAPI.getHoldings();

  HoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      appBar: AppBar(
        leading: Icon(
          Icons.account_balance_wallet,
          size: 28,
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade500,
                Colors.deepPurple.shade700,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text(
          holding,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: holdings.isNotEmpty
          ? Column(
              children: [
                _buildSummaryCard(),
                Expanded(
                  child: ListView.builder(
                    itemCount: holdings.length,
                    itemBuilder: (context, index) {
                      final holding = holdings[index];
                      return _buildHoldingCard(context, holding);
                    },
                  ),
                ),
              ],
            )
          : NothingFoundWidget(
              message: "We Couldn't find anything in Holdings"),
    );
  }

  Widget _buildSummaryCard() {
    final totalPnl = holdings.fold(0.0, (sum, holding) => sum + holding.pnl);
    final totalValue =
        holdings.fold(0.0, (sum, holding) => sum + holding.currentValue);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$totalValue',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              Text('₹${totalValue.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(totalPL,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              Text(
                '₹${totalPnl.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: totalPnl >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingCard(BuildContext context, Holding holding) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => showOrderPad(context, holding.stock, buy),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(holding.stock.symbol,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(holding.stock.name,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${holding.stock.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        '${holding.stock.change >= 0 ? '+' : ''}${holding.stock.change.toStringAsFixed(2)} (${holding.stock.changePercent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          fontSize: 12,
                          color: holding.stock.change >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$qty: ${holding.quantity}',
                      style: TextStyle(fontSize: 14)),
                  Text('$avg: ₹${holding.avgPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14)),
                  Text(
                    '$pl: ₹${holding.pnl.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: holding.pnl >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
