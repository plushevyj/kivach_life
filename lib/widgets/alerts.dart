import 'package:doctor/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessAlert(String message,
    {Duration duration = const Duration(seconds: 5)}) {
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
    {Duration duration = const Duration(seconds: 5)}) {
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
              style: TextStyle(color: KivachColors.green),
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
    backgroundColor: Colors.grey.shade100,
    colorText: Colors.black,
    snackPosition: SnackPosition.TOP,
  );
}

SnackbarController showMessageAlert(
    {required String title,
    required String message,
    Duration duration = const Duration(seconds: 5),
    Widget? icon,
    TextButton? mainButton}) {
  return Get.snackbar(
    title,
    message,
    duration: duration,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 2,
        offset: const Offset(1, 1),
      )
    ],
    backgroundColor: Colors.white,
    colorText: Colors.black,
    snackPosition: SnackPosition.TOP,
    icon: icon,
    mainButton: mainButton,
  );
}
