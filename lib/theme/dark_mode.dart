import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 51, 51, 51),
    inversePrimary: Colors.grey.shade300,
  ),
  brightness: Brightness.dark,
);
