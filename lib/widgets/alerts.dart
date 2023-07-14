import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String errorMessage) {
  Get.snackbar(
    'Ошибка',
    errorMessage,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.zero,
    borderRadius: 0,
  );
}
