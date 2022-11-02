import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New mouse',
      amount: 350,
      date: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 150,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 150,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions => _userTransactions
      .where(
          (tx) => DateTime.now().difference(tx.date) <= const Duration(days: 7))
      .toList();

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final lastId =
        _userTransactions.isEmpty ? 't0' : _userTransactions.first.id;
    final newId = int.parse(lastId.substring(1)) + 1;
    final newTransaction = Transaction(
      id: 't$newId',
      title: txTitle,
      amount: txAmount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = true;

  void _showInputs(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(addTransaction: _addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _showInputs(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ))
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: [
              IconButton(
                onPressed: () => _showInputs(context),
                icon: const Icon(Icons.add),
              ),
            ],
          )) as PreferredSizeWidget;
    final transactionListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: TransactionList(_userTransactions,
          deleteTransaction: _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show chart'),
                  Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) transactionListWidget,
            _showChart
                ? SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.75,
                    child: Chart(_recentTransactions))
                : transactionListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _showInputs(context),
                    child: const Icon(Icons.add),
                  ),
            body: pageBody);
  }
}
