import 'package:flutter/material.dart';

final byteBankTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.green[900],
    secondary: Colors.blueAccent[700],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.blueAccent[700],
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent[700],
    textTheme: ButtonTextTheme.normal,
  ),
);
