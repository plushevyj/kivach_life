import 'package:flutter/material.dart';

const pagePadding = EdgeInsets.symmetric(horizontal: 20);

final onboardingButtonStyle = ButtonStyle(
  textStyle: MaterialStateProperty.all(
    const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  foregroundColor: MaterialStateProperty.all(KivachColors.green),
  overlayColor: MaterialStateProperty.all(KivachColors.green.withOpacity(0.2)),
);

abstract final class KivachColors {
  static const green = Color(0xFF1A7A5C);
  static const lightGreen = Color(0xFF66A67E);
  static const green2 = Color(0xFF93AC9F);
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
    errorBorder: outlineInputBorder,
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
      backgroundColor: MaterialStateProperty.resolveWith((state) {
        if (state.contains(MaterialState.disabled)) {
          return KivachColors.green2;
        }
        return KivachColors.green;
      }),
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
