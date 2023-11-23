import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppUpdateUI {
  void showInAppUpdateIOSModal(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Доступна новая версия приложения'),
          content: const Text('Перейдите в AppStore для обновления'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text(
                'Позже',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                try {
                  launchUrl(
                    Uri.parse(
                        'https://apps.apple.com/ru/app/kivach-life/id1594326685'),
                    mode: LaunchMode.externalApplication,
                  );
                } catch (_) {}
                Get.back();
              },
              child: const Text(
                'Перейти',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
