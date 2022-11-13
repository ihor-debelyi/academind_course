// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  final currencyFormat = NumberFormat.simpleCurrency();

  CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (direction) =>
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(productId),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
        child: ListTile(
          leading: Image.network(
            imageUrl,
            height: 100,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(title),
          subtitle: Text('Total: ${currencyFormat.format(quantity * price)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
