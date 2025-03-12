import 'package:flutter/material.dart';

abstract class AppTheme {
  static final appTheme = ThemeData(
    colorScheme: const ColorScheme.dark(primary: Color(0xff01C5D3)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff1e1e1e),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xff3c3c3c)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xff3c3c3c)),
      ),
    ),
  );
}
