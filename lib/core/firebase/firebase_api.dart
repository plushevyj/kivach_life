import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../modules/push_notifications/repository/push_notifications_repository.dart';
import '/widgets/alerts.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      await const PushNotificationsRepository()
          .setTokenPushNotifications(token: fCMToken);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
    if (kDebugMode) {
      print('token = ${fCMToken.toString()}');
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      print(
          'message = ${message.notification?.title} : ${message.notification?.body}');
    }
    showNotificationAlert(message);
  }
}
