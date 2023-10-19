import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' show Navigator;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import '/modules/push_notifications/repository/push_notifications_repository.dart';
import '/widgets/alerts.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) async {
      print(
          'message.data = ${message.data} ${message.data['href'].runtimeType}');
      Get.find<ConfigurationOfAppController>().url.value =
          message.data['href']['url'];
      print(
          'Get.find<ConfigurationOfAppController>().url.value = ${Get.find<ConfigurationOfAppController>().url.value}');
      //{"view":"web","url":"https:\/\/mobile-doctors.kivach.ru\/chat?conversation=0"}}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print(
          'message.data = ${message.data} ${message.data['href'].runtimeType}');
      Get.find<ConfigurationOfAppController>().url.value =
          message.data['href']['url'];
      print(Get.find<ConfigurationOfAppController>().url.value);
    });
  }

  Future<void> sendToken() async {
    try {
      final fCMToken = await _firebaseMessaging.getToken();
      if (fCMToken != null) {
        await const PushNotificationsRepository()
            .setTokenPushNotifications(token: fCMToken);
      }
    } catch (error) {
      showErrorAlert(error.toString());
    }
  }
}
