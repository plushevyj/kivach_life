import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/core/themes/light_theme.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

Future<void> showLogOutAlert() {
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
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: CupertinoAlertDialog(
            title: const Text(title),
            content: const Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(
                  cancelButtonText,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Get.context!
                      .read<LocalAuthenticationBloc>()
                      .add(const LocallyLogOut());
                  Get.context!.read<AuthenticationBloc>().add(const LogOut());
                  Get.offAllNamed('/auth');
                },
                child: const Text(
                  successButtonText,
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                foregroundColor: Colors.white,
                backgroundColor: KivachColors.green,
                minimumSize: const Size(30, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {
                Get.context!
                    .read<LocalAuthenticationBloc>()
                    .add(const LocallyLogOut());
                Get.context!.read<AuthenticationBloc>().add(const LogOut());
                Get.offAllNamed('/auth');
              },
              child: const Text(successButtonText),
            ),
          ],
        );
      },
    );
  }
}
