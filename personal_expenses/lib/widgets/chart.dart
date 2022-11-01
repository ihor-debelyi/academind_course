import 'package:flutter/material.dart';
import 'package:personal_expenses/models/chart_transaction.dart';
import 'package:personal_expenses/models/datetime_extensions.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<ChartTransaction> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var transaction in recentTransactions) {
        if (transaction.date.isSameDateAs(weekDay)) {
          totalSum += transaction.amount;
        }
      }
      return ChartTransaction(DateFormat.E().format(weekDay), totalSum);
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((tx) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      chartTransaction: tx,
                      spendingPercentage: totalSpending == 0.0
                          ? 0.0
                          : tx.amount / totalSpending,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
