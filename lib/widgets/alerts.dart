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

void showNotificationAlert({
  String? title,
  String? message,
  VoidCallback? onMainButtonPressed,
  Duration duration = const Duration(seconds: 20),
}) {
  Get.snackbar(
    title ?? 'Неизвестное сообщение',
    message ?? 'Неизвестное сообщение',
    onTap: (_) {
      onMainButtonPressed?.call();
      Get.closeCurrentSnackbar();
    },
    mainButton: onMainButtonPressed != null
        ? TextButton(
            onPressed: () {
              onMainButtonPressed.call();
              Get.closeCurrentSnackbar();
            },
            child: const Text(
              'Перейти',
              style: TextStyle(color: Colors.blue),
            ),
          )
        : null,
    duration: duration,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 1,
        offset: const Offset(1, 1),
      )
    ],
    backgroundColor: const Color(0xFFEFEFEF),
    colorText: Colors.black,
    snackPosition: SnackPosition.TOP,
  );
}
