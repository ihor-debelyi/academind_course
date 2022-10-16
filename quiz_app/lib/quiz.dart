import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import 'package:quiz_app/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function callback;

  const Quiz({
    Key? key,
    required this.questions,
    required this.questionIndex,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((x) {
          int score = x['score'] as int;
          return Answer(
            content: x['text'] as String,
            callback: () => callback(score),
          );
        }).toList()
      ],
    );
  }
}
