// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:personal_expenses/models/chart_transaction.dart';

class ChartBar extends StatelessWidget {
  final ChartTransaction chartTransaction;
  final double spendingPercentage;

  const ChartBar({
    Key? key,
    required this.chartTransaction,
    required this.spendingPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${chartTransaction.amount.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1.0),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        // Text((chartTransaction.amount / totalSpending).toStringAsFixed(2)),
        const SizedBox(height: 5),
        Text(chartTransaction.day),
      ],
    );
  }
}
