import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String content;
  final VoidCallback callback;

  const Answer({required this.callback, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange[300]),
        ),
        onPressed: callback,
        child: Text(content),
      ),
    );
  }
}
