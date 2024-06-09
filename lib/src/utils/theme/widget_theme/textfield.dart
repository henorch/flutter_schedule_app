import 'package:flutter/material.dart';

class HTextFieldTheme {
  static InputDecorationTheme lightTheme =
      InputDecorationTheme(outlineBorder: BorderSide(color: Colors.black));

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    prefixStyle: TextStyle(color: Colors.blue),
    hintStyle: TextStyle(color: Colors.white54),
  );
}
