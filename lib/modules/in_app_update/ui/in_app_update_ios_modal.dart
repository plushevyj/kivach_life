import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

class InAppUpdateUI {
  void showInAppUpdateIOSModal() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (ctx) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.blue,
          ),
          child: CupertinoAlertDialog(
            title: const Text('Доступна новая версия приложения'),
            content: const Text('Перейдите в AppStore для обновления'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(
                  'Позже',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  try {
                    StoreRedirect.redirect(iOSAppId: '1594326685');
                  } catch (_) {}
                  Get.back();
                },
                child: const Text(
                  'Перейти',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
