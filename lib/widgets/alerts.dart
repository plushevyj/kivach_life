import 'package:firebase_messaging/firebase_messaging.dart';
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

void showNotificationAlert(RemoteMessage message,
    {Duration duration = const Duration(seconds: 20)}) {
  Get.snackbar(
    message.notification?.title ?? 'Уведомление',
    message.notification?.body ?? '404',
    mainButton: TextButton(
      child: const Text(
        'Перейти',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {},
    ),
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
