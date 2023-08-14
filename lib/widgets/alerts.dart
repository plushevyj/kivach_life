import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessAlert(String message,
    {Duration duration = const Duration(seconds: 2)}) {
  Get.snackbar(
    'Успешно',
    message,
    duration: duration,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
  );
}

void showErrorAlert(String message,
    {Duration duration = const Duration(seconds: 2)}) {
  Get.snackbar(
    'Ошибка',
    message,
    duration: duration,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
  );
}
