import 'package:flutter/material.dart';
import 'package:get/get.dart';

// final isSmallScreen = (Get.width <= 400) || (Get.height <= 690);
// final isSmallScreen = (MediaQuery.of(Get.context!).size.width <= 400) ||
//     (MediaQuery.of(Get.context!).size.height <= 690);
const isSmallScreen = true;

const pagePadding = EdgeInsets.symmetric(horizontal: 20);

final onboardingButtonStyle = ButtonStyle(
  textStyle: WidgetStateProperty.all(
    const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  foregroundColor: WidgetStateProperty.all(KivachColors.green),
  overlayColor: WidgetStateProperty.all(KivachColors.green.withOpacity(0.2)),
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
      iconColor: WidgetStateProperty.all(Colors.black),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    labelStyle: TextStyle(
      color: KivachColors.green,
      fontSize: isSmallScreen ? 16 : null,
    ),
    suffixIconColor: KivachColors.green,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: KivachColors.green,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16),
      ),
      foregroundColor: WidgetStateProperty.all(KivachColors.green),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16),
      ),
      backgroundColor: WidgetStateProperty.all(KivachColors.green),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      minimumSize: WidgetStateProperty.all(
        const Size(double.infinity, isSmallScreen ? 55 : 60),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide.none,
        ),
      ),
    ),
  ),
);
