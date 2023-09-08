import 'dart:io';

import 'package:doctor/core/themes/light_theme.dart';
import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:doctor/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> showLogOutAlert() {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: Get.context!,
      builder: (ctx) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: CupertinoAlertDialog(
            title: const Text('Выход'),
            content: const Text('Вы действительно хотите выйти из аккаунта?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(
                  'Отмена',
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
                  'Да',
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
          title: const Text('Выход'),
          content: const Text('Вы действительно хотите выйти из аккаунта?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: KivachColors.green),
              onPressed: () => Get.back(),
              child: const Text('Отмена'),
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
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }
}
