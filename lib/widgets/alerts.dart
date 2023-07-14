import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String errorMessage,
    {Duration duration = const Duration(seconds: 3)}) {
  Get.snackbar(
    'Ошибка',
    errorMessage,
    duration: duration,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.zero,
    borderRadius: 0,
  );
}
