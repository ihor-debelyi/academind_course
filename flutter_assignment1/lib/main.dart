import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_assignment1/custom_text.dart';

void main() => runApp(TestApp());

class TestApp extends StatefulWidget {
  TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final _phrases = const [
    'Hello',
    'How are you?',
    'I am fine',
    'Goodbye',
  ];

  int _idx = 0;

  void getNewIndex() {
    int max = _phrases.length;
    setState(() {
      _idx = new Random().nextInt(max);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Assignment 1'),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(_phrases[_idx]),
                ElevatedButton(
                    onPressed: getNewIndex, child: const Text('New phrase')),
              ],
            ),
          )),
    );
  }
}
