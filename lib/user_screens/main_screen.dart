import '../mocks/api.dart';
import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../utils/constants.dart';
import '../utils/extensions.dart';
import 'index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  double _x = 300;
  double _y = 500;

  late AnimationController _animationController;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;

  int _currentIndex = 0;
  late AnimationController _fabController;
  bool _isFabExpanded = false;

  final List<Widget> _screens = [
    HoldingsScreen(),
    OrderbookScreen(),
    PositionsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fabController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _snapToSide() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the closest side
    double targetX;
    double targetY = _y;

    // Calculate expanded width (3 FABs + spacing)
    double expandedWidth = 56 * 3 + 16; // 3 FABs + 2 gaps of 8px each
    double collapsedWidth = 56; // Just one FAB

    // Determine if it should snap to left or right side
    if (_x < screenWidth / 2) {
      // Snap to left side
      targetX = 16.0; // 16px from left edge
    } else {
      // Snap to right side - consider expanded state
      if (_isFabExpanded) {
        // When expanded, ensure the entire expanded FAB fits
        targetX = screenWidth - expandedWidth - 16.0;
      } else {
        // When collapsed, position for single FAB
        targetX = screenWidth - collapsedWidth - 16.0;
      }
    }

    // Keep Y within screen bounds
    targetY = targetY.clamp(56.0, screenHeight - 120.0);

    // Create animations
    _xAnimation = Tween<double>(
      begin: _x,
      end: targetX,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _yAnimation = Tween<double>(
      begin: _y,
      end: targetY,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    // Start animation
    _animationController.forward(from: 0).then((_) {
      setState(() {
        _x = targetX;
        _y = targetY;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          _screens[_currentIndex],

          // Draggable FAB
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              double currentX =
                  _animationController.isAnimating ? _xAnimation.value : _x;
              double currentY =
                  _animationController.isAnimating ? _yAnimation.value : _y;

              return Positioned(
                left: currentX,
                top: currentY,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (!_animationController.isAnimating) {
                      setState(() {
                        _x += details.delta.dx;
                        _y += details.delta.dy;

                        // Keep within screen bounds while dragging
                        final screenWidth = MediaQuery.of(context).size.width;
                        final screenHeight = MediaQuery.of(context).size.height;

                        // Calculate current width based on expansion state
                        double currentWidth =
                            _isFabExpanded ? (56 * 3 + 16) : 56;
                        _x = _x.clamp(0.0, screenWidth - currentWidth);
                        _y = _y.clamp(0.0, screenHeight - 120.0);
                      });
                    }
                  },
                  onPanEnd: (details) {
                    _snapToSide();
                  },
                  child: _buildFAB(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple.shade700,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: holding,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: orderbook,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: positions,
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isOnLeftSide = _x < screenWidth / 2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.black.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // When on left side, show main button first, then expanded buttons
          if (isOnLeftSide) ...[
            // Main FAB button on the left
            plusSignFloatingActionButton(),

            // Expanded buttons to the right
            if (_isFabExpanded) ...[
              SizedBox(width: 8),
              // Buy button
              buyButton(),
              SizedBox(width: 8),
              // Sell button
              sellButton(),
            ],
          ] else ...[
            // When on right side, show expanded buttons first, then main button
            // Expanded buttons to the left
            if (_isFabExpanded) ...[
              // Buy button (appears first when expanding from right)
              buyButton(),
              SizedBox(width: 8),
              // Sell button
              sellButton(),
              SizedBox(width: 8),
            ],

            // Main FAB button on the right
            plusSignFloatingActionButton(),
          ],
        ],
      ),
    );
  }

  Widget sellFAB() {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.shade400,
              Colors.red.shade600,
              Colors.red.shade800,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: sell.toLowerCase(),
          onPressed: () => _handleFabAction(sell),
          backgroundColor: Colors.red,
          shape: CircleBorder(),
          elevation: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_down, color: Colors.white),
              Text(
                sell,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  Widget buyFAB() {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade400,
              Colors.green.shade600,
              Colors.green.shade800,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: buy.toLowerCase(),
          onPressed: () => _handleFabAction(buy),
          backgroundColor: Colors.green,
          shape: CircleBorder(),
          elevation: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_up, color: Colors.white),
              Text(
                buy,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  AnimatedScale buyButton() {
    return AnimatedScale(
      scale: _isFabExpanded ? 1.0 : 0.0,
      duration: Duration(milliseconds: 350),
      curve: Curves.elasticOut,
      child: AnimatedOpacity(
        opacity: _isFabExpanded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: buyFAB(),
      ),
    );
  }

  AnimatedScale sellButton() {
    return AnimatedScale(
      scale: _isFabExpanded ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      child: AnimatedOpacity(
        opacity: _isFabExpanded ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        child: sellFAB(),
      ),
    );
  }

  Widget plusSignFloatingActionButton() {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade400,
              Colors.purple.shade700,
              Colors.purple.shade900,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.4),
              blurRadius: _isFabExpanded ? 15 : 10,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              blurRadius: 25,
              offset: Offset(0, 10),
              spreadRadius: _isFabExpanded ? 2 : 0,
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: "main",
          onPressed: _toggleFab,
          backgroundColor:
              _isFabExpanded ? Colors.purple.shade700 : Colors.purple,
          elevation: _isFabExpanded ? 12 : 6,
          shape: CircleBorder(),
          child: AnimatedRotation(
            turns: _isFabExpanded ? 0.125 : 0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                _isFabExpanded ? Icons.close : Icons.add,
                key: ValueKey(_isFabExpanded),
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  void _toggleFab() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isOnRightSide = _x > screenWidth / 2;

    setState(() {
      _isFabExpanded = !_isFabExpanded;
    });

    // Adjust position when expanding/collapsing to prevent hiding
    if (isOnRightSide) {
      double newX;
      if (_isFabExpanded) {
        // When expanding, calculate required width and position accordingly
        double expandedWidth = 56 * 3 + 16; // 3 FABs + spacing
        newX = (screenWidth - expandedWidth - 16.0)
            .clamp(0.0, screenWidth - expandedWidth);
      } else {
        // When collapsing, move to standard right position
        newX = screenWidth - 56 - 16.0; // Single FAB + padding
      }

      // Only animate if position actually needs to change
      if ((newX - _x).abs() > 1.0) {
        _xAnimation = Tween<double>(
          begin: _x,
          end: newX,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
        ));

        _yAnimation = Tween<double>(
          begin: _y,
          end: _y, // Y position stays the same
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
        ));

        _animationController.forward(from: 0).then((_) {
          setState(() {
            _x = newX;
          });
        });
      }
    }
    // For left side, no position adjustment needed as expansion goes to the right
  }

  void _handleFabAction(String orderType) {
    _toggleFab();

    Stock? stock;

    switch (_currentIndex) {
      case 0:
        stock = MockAPI.getHoldings().isNotEmpty
            ? MockAPI.getHoldings().first.stock
            : null;
        break;
      case 1:
        stock = MockAPI.getOrders().isNotEmpty
            ? MockAPI.getOrders().first.stock
            : null;
        break;
      case 2:
        stock = MockAPI.getPositions().isNotEmpty
            ? MockAPI.getPositions().first.stock
            : null;
        break;
      default:
        stock = null;
    }
    if (stock != null) {
      showOrderPad(context, stock, orderType);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No stocks available on current page'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
