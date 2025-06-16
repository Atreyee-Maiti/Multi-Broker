import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../utils/constants.dart';

class OrderPad extends StatefulWidget {
  final Stock stock;
  final String orderType;

  const OrderPad({super.key, required this.stock, required this.orderType});

  @override
  OrderPadState createState() => OrderPadState();
}

class OrderPadState extends State<OrderPad> {
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  String _orderTyp = market;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.stock.price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final isBuy = widget.orderType == buy;
    final color = isBuy ? Colors.green : Colors.red;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header - Made more compact
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Reduced vertical padding
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.orderType} ${widget.stock.symbol}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold), // Reduced font size
                    ),
                    Text(
                      widget.stock.name,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12), // Reduced font size
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close,
                      color: Colors.white, size: 20), // Smaller icon
                  padding: EdgeInsets.all(4), // Reduced padding
                  constraints: BoxConstraints(
                      minWidth: 32, minHeight: 32), // Smaller button
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current price - Made more compact
                  Text(
                      'Current Price: ₹${widget.stock.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)), // Reduced font size
                  SizedBox(height: 16), // Reduced spacing

                  // Error message display
                  if (_errorMessage != null) ...[
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              color: Colors.red, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                  ],

                  // Order type selector - Made more compact
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _orderTyp = market),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10), // Reduced padding
                            decoration: BoxDecoration(
                              color: _orderTyp == market
                                  ? color.withOpacity(0.1)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _orderTyp == market
                                    ? color
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                market,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14, // Reduced font size
                                  color: _orderTyp == market
                                      ? color
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12), // Reduced spacing
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _orderTyp = limit;
                            _clearError(); // Clear error when changing order type
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10), // Reduced padding
                            decoration: BoxDecoration(
                              color: _orderTyp == limit
                                  ? color.withOpacity(0.1)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _orderTyp == limit
                                    ? color
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                limit,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14, // Reduced font size
                                  color: _orderTyp == limit
                                      ? color
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Reduced spacing

                  // Quantity field - Made more compact
                  SizedBox(
                    height: 50, // Fixed height for compactness
                    child: TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: quantity,
                        border: OutlineInputBorder(),
                        prefixIcon:
                            Icon(Icons.shopping_cart, size: 20), // Smaller icon
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8), // Reduced padding
                        labelStyle: TextStyle(fontSize: 14), // Smaller label
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 14), // Smaller text
                      onChanged: (value) =>
                          _clearError(), // Clear error when typing
                    ),
                  ),
                  SizedBox(height: 12), // Reduced spacing

                  // Price field (only for LIMIT orders) - Made more compact
                  if (_orderTyp == limit)
                    SizedBox(
                      height: 50, // Fixed height for compactness
                      child: TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: price,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.currency_rupee,
                              size: 20), // Smaller icon
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8), // Reduced padding
                          labelStyle: TextStyle(fontSize: 14), // Smaller label
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 14), // Smaller text
                        onChanged: (value) =>
                            _clearError(), // Clear error when typing
                      ),
                    ),
                  if (_orderTyp == limit)
                    SizedBox(height: 16), // Reduced spacing

                  Spacer(),

                  // Place order button - Made more compact
                  SizedBox(
                    width: double.infinity,
                    height: 45, // Reduced height
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        '${widget.orderType} ${widget.stock.symbol}',
                        style: TextStyle(
                          fontSize: 16, // Reduced font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Reduced bottom spacing
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    // Clear any existing error
    setState(() {
      _errorMessage = null;
    });

    // Validate quantity
    if (_quantityController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter quantity';
      });
      return;
    }

    // Validate quantity is a valid number
    final quantity = int.tryParse(_quantityController.text);
    if (quantity == null || quantity <= 0) {
      setState(() {
        _errorMessage = validQuantity;
      });
      return;
    }

    // Validate price for LIMIT orders
    if (_orderTyp == limit) {
      if (_priceController.text.isEmpty) {
        setState(() {
          _errorMessage = enterPrice;
        });
        return;
      }

      // Validate price is a valid number
      final price = double.tryParse(_priceController.text);
      if (price == null || price <= 0) {
        setState(() {
          _errorMessage = validPrice;
        });
        return;
      }
    }

    // Mock order placement
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${widget.orderType} $orderPlaced ${widget.stock.symbol} will be reflected in 4 to 5 business days on OderBook'),
        backgroundColor: widget.orderType == buy ? Colors.green : Colors.red,
      ),
    );
  }

  void _clearError() {
    if (_errorMessage != null) {
      setState(() {
        _errorMessage = null;
      });
    }
  }
}
