import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetHandler;

  const Result({
    Key? key,
    required this.totalScore,
    required this.resetHandler,
  }) : super(key: key);

  String get resultPhrase {
    if (totalScore <= 8) {
      return 'You are awesome and innocent!';
    }
    if (totalScore <= 12) {
      return 'Pretty likeable!';
    }
    if (totalScore <= 16) {
      return 'You are ... strange?!';
    }
    return 'You are so bad!';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$resultPhrase Your score is $totalScore',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            OutlinedButton(
              onPressed: resetHandler,
              child: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
