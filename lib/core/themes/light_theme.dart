import 'package:flutter/material.dart';

const pagePadding = EdgeInsets.symmetric(horizontal: 20);

abstract final class KivachColors {
  static const green = Color(0xFF016836);
  static const lightGreen = Color(0xFF66A67E);
}

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    width: 2,
    color: KivachColors.green,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    labelStyle: const TextStyle(color: KivachColors.green),
    suffixIconColor: KivachColors.green,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: KivachColors.green,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(KivachColors.green),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide.none,
        ),
      ),
    ),
  ),
);
