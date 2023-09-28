import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../modules/push_notifications/repository/push_notifications_repository.dart';
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
  }

  Future<void> sendToken() async {
    try {
      final fCMToken = await _firebaseMessaging.getToken();
      await Clipboard.setData(ClipboardData(text: fCMToken.toString()));
      if (fCMToken != null) {
        await const PushNotificationsRepository()
            .setTokenPushNotifications(token: fCMToken);
      }
    } catch (error) {
      showErrorAlert(error.toString());
      await Clipboard.setData(ClipboardData(text: error.toString()));
    }
  }
}
