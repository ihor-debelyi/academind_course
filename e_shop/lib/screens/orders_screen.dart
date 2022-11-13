import 'package:e_shop/widgets/main_drawer.dart';
import 'package:e_shop/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const MainDrawer(),
      body: Consumer<OrdersProvider>(
        builder: (context, orderData, child) {
          return ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orderData.orders[index]);
            },
          );
        },
      ),
    );
  }
}
