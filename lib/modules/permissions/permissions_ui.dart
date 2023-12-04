import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHandlerUI {
  static Future<bool> checkPermission(Permission permission) async {
    if (!await permission.isGranted) {
      StreamSubscription subscription = Stream.periodic(
              const Duration(milliseconds: 500), (_) => permission.status)
          .listen((status) async {
        if (await status.isGranted) {
          Get.back();
        }
      });
      final messageComponent = switch (permission) {
        Permission.camera => 'камеры',
        Permission.photos => 'галереи',
        _ => 'требуемого модуля устройства',
      };
      await Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Text(
                'Необходимо предоставить разрешение на использование $messageComponent. Для этого перейдите в настройки приложения "Kivach Life" в раздел "Разрешения"',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Позже'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(30, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                    ),
                    onPressed: () async {
                      await openAppSettings();
                    },
                    child: const Text('Перейти'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        elevation: 20,
      );
      subscription.cancel();
    }
    return await permission.isGranted;
  }
}
