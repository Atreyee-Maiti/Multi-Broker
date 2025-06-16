import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../mocks/api.dart';
import '../utils/extensions.dart';
import '../utils/constants.dart' as constant;
import 'empty_screen.dart';

class PositionsScreen extends StatelessWidget {
  final List<Position> positions = MockAPI.getPositions();

  PositionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      appBar: AppBar(
        leading: Icon(
          Icons.trending_up,
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
          constant.positions,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: positions.isNotEmpty
          ? Column(
              children: [
                _buildPnlCard(),
                Expanded(
                  child: ListView.builder(
                    itemCount: positions.length,
                    itemBuilder: (context, index) {
                      final position = positions[index];
                      return _buildPositionCard(context, position);
                    },
                  ),
                ),
              ],
            )
          : NothingFoundWidget(message: "Your OrdersBook is Empty"),
    );
  }

  Widget _buildPnlCard() {
    final totalPnl = positions.fold(0.0, (sum, position) => sum + position.pnl);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: totalPnl >= 0 ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: totalPnl >= 0 ? Colors.green.shade200 : Colors.red.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(constant.totalPL,
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
          Icon(
            totalPnl >= 0 ? Icons.trending_up : Icons.trending_down,
            color: totalPnl >= 0 ? Colors.green : Colors.red,
            size: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildPositionCard(BuildContext context, Position position) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => showOrderPad(context, position.stock,
            position.type == 'LONG' ? constant.sell : constant.buy),
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
                      Text(position.stock.symbol,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(position.stock.name,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          position.type == 'LONG' ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      position.type,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${constant.qty}: ${position.quantity}',
                      style: TextStyle(fontSize: 14)),
                  Text(
                      '${constant.entry}: ₹${position.entryPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14)),
                  Text(
                    '${constant.pl}: ₹${position.pnl.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: position.pnl >= 0 ? Colors.green : Colors.red,
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
