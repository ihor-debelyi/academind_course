import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<CartItem> cartProducts, double total) {
    final order = Order(
      id: DateTime.now().toString(),
      products: cartProducts,
      amount: total,
      dateTime: DateTime.now(),
    );
    _orders.insert(0, order);
    notifyListeners();
  }
}
