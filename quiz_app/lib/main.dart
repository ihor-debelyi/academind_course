import 'package:flutter/material.dart';

import './question.dart';
import 'answer.dart';

void main() => runApp(QuizzApp());

class QuizzApp extends StatefulWidget {
  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex += 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'What\'s your favourite color?',
      'What\'s your favourite animal?'
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My first App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Question(questions[_questionIndex]),
            Answer(
              content: 'Answer 1',
              callback: _answerQuestion,
            ),
            Answer(
              content: 'Answer 2',
              callback: _answerQuestion,
            ),
            Answer(
              content: 'Answer 3',
              callback: _answerQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
