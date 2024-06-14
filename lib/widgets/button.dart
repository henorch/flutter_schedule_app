import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Function()? handlePress;
  const MyButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.handlePress});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(backgroundColor)),
        onPressed: handlePress,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 25.0,
              fontFamily: 'PoetsenOne',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ));
  }
}
