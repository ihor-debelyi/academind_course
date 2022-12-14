import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction({Key? key, required this.addTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;

    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _pickedDate == null) {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount, _pickedDate!);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _pickedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      _pickedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat('dd/MM/yyyy').format(_pickedDate!)}',
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor),
                      onPressed: _presentDatePicker,
                      child: const Text('Choose Date'),
                    )
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _submitData,
                      child: const Text('Add Transaction'),
                    )
                  : ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor:
                              Theme.of(context).textTheme.button!.color),
                      child: const Text('Add Transaction'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
