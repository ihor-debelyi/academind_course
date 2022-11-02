import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions,
      {Key? key, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, idx) => TransactionCard(
                transaction: transactions[idx],
                deleteTransaction: deleteTransaction),
            itemCount: transactions.length,
          );
  }
}
