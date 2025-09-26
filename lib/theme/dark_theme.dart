import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
