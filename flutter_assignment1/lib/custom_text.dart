import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  const CustomText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
      ),
    );
  }
}
