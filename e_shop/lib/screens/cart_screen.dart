import 'package:e_shop/providers/cart_provider.dart' show CartProvider;
import 'package:e_shop/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  CartScreen({Key? key}) : super(key: key);

  final currencyFormat = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      currencyFormat.format(cart.totalAmount),
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: ((context, index) {
                var cartItem = cart.items.values.toList()[index];
                final productId = cart.items.keys.toList()[index];
                return CartItem(
                  id: cartItem.id,
                  productId: productId,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                  title: cartItem.title,
                  imageUrl: cartItem.imageUrl,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
