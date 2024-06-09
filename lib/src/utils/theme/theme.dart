import 'package:flutter/material.dart';
import 'package:world_times/src/utils/theme/widget_theme/textfield.dart';

class HAppTheme {
  HAppTheme._();
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      inputDecorationTheme:
          InputDecorationTheme(outlineBorder: BorderSide(color: Colors.black)));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme: HTextFieldTheme.darkTheme,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.blue,
        selectionColor: Colors.blue.withOpacity(0.5),
        selectionHandleColor: Colors.blue,
      ));
}
