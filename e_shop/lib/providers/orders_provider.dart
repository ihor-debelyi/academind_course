import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';
import '../models/order.dart';
import '../api_routes.dart' as api_routes;

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> fetchOrders() async {
    final url = Uri.https(api_routes.baseUrl, api_routes.orders);
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Order> fetchedOrders = [];
      extractedData.forEach((id, orderData) {
        fetchedOrders.add(Order.fromJson(id, orderData));
      });
      _orders = fetchedOrders;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final order = Order(
      id: DateTime.now().toString(),
      products: cartProducts,
      amount: total,
      dateTime: DateTime.now(),
    );

    final url = Uri.https(api_routes.baseUrl, api_routes.orders);
    try {
      final response = await http.post(
        url,
        body: json.encode(order.toMap()),
      );
      final orderToAdd = order.copyWith(
        id: json.decode(response.body)['name'],
      );
      _orders.add(orderToAdd);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
