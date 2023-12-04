import 'dart:io';

import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:doctor/pages/home_page/home_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/themes/light_theme.dart';

Future<void> showLogOutAlert({bool isNative = false}) {
  const title = 'Вы действительно хотите выйти из аккаунта?';
  const message =
      'Данные авторизации, биометрии и цифровой пароль будут сброшены. Для '
      'повторного входа в личный кабинет необходимо будет заново ввести логин '
      'и пароль.';
  const successButtonText = 'Да';
  const cancelButtonText = 'Отмена';
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: Get.context!,
      builder: (ctx) {
        return Theme(
          data: ThemeData(),
          child: CupertinoAlertDialog(
            title: const Text(title),
            content: const Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(
                  cancelButtonText,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () => isNative
                    ? logOut()
                    : Get.find<HomePageController>()
                        .loadBaseSiteRoute(route: '/logout'),
                child: const Text(
                  successButtonText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  } else {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text(title),
          content: const Text(message),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: KivachColors.green),
              onPressed: () => Get.back(),
              child: const Text(cancelButtonText),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(30, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () => Get.find<HomePageController>()
                  .loadBaseSiteRoute(route: '/logout'),
              child: const Text(successButtonText),
            ),
          ],
        );
      },
    );
  }
}
