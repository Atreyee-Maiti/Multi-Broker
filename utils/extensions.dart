import 'package:flutter/material.dart';

import '../content_models/index.dart';
import '../mocks/api.dart';
import '../user_screens/order_pad.dart';

void showOrderPad(BuildContext context, Stock stock, String orderType) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => OrderPad(stock: stock, orderType: orderType),
  );
}
