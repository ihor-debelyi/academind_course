import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return TransactionCard(transaction: transactions[idx]);
        },
        itemCount: transactions.length,
      ),
    );
  }
}
