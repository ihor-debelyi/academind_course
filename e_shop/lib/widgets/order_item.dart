// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final currencyFormat = NumberFormat.simpleCurrency();
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(currencyFormat.format(widget.order.amount)),
          subtitle: Text(
            DateFormat('dd.MM.yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Column(
            children: [
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              Container(
                height: min(widget.order.products.length * 30.0 + 15, 100),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (context, index) {
                    var product = widget.order.products[index];
                    return SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity}x ${currencyFormat.format(product.price)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
