import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    elevation: 2,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.black87,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 2,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
  ),
);