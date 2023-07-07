import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
);
