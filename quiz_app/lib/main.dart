import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/result.dart';

void main() => runApp(QuizzApp());

class QuizzApp extends StatefulWidget {
  const QuizzApp({super.key});

  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  var _questionIndex = 0;
  int _totalScore = 0;
  final _questions = const [
    {
      'questionText': 'What\'s your favourite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 2},
        {'text': 'White', 'score': 1}
      ]
    },
    {
      'questionText': 'What\'s your favourite animal?',
      'answers': [
        {'text': 'Snake', 'score': 15},
        {'text': 'Elephant', 'score': 10},
        {'text': 'Lion', 'score': 5},
        {'text': 'Rabbit', 'score': 2},
        {'text': 'Dog', 'score': 1},
      ]
    },
    {
      'questionText': 'What\'s your programming language ?',
      'answers': [
        {'text': 'Java', 'score': 10},
        {'text': 'JavaScript', 'score': 5},
        {'text': 'Go', 'score': 5},
        {'text': 'Python', 'score': 2},
        {'text': 'C#', 'score': 2},
      ]
    }
  ];

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My first App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                callback: _answerQuestion)
            : Result(
                totalScore: _totalScore,
                resetHandler: _resetQuiz,
              ),
      ),
    );
  }
}
