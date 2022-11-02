import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionCard(
      {Key? key, required this.transaction, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor),
                onPressed: () => deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
      // child: Row(
      //   children: [
      //     Container(
      //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //       child: Text(
      //         '\$${transaction.amount.toStringAsFixed(2)}',
      //         style: TextStyle(
      //           color: Theme.of(context).primaryColor,
      //           fontSize: 25,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           transaction.title,
      //           style: Theme.of(context).textTheme.headline6,
      //         ),
      //         const SizedBox(height: 5),
      //         Text(
      //           DateFormat.yMMMd().format(transaction.date),
      //           style: const TextStyle(
      //             fontSize: 14,
      //             color: Colors.grey,
      //           ),
      //         ),
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
