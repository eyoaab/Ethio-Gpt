import 'package:flutter/material.dart';

class EthioGptTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: Colors.grey,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    disabledColor: Colors.grey,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
  );
}
