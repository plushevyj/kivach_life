import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../modules/push_notifications/repository/push_notifications_repository.dart';
import '/widgets/alerts.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackGroundMessage);
  }

  Future<void> sendToken() async {
    final fCMToken = await _firebaseMessaging.getToken();
    print('fCMToken = $fCMToken');
    if (fCMToken != null) {
      await const PushNotificationsRepository()
          .setTokenPushNotifications(token: fCMToken);
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      print(
          'message = ${message.notification?.title} : ${message.notification?.body}');
    }
    showNotificationAlert(message);
  }

  Future<void> _handleBackGroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print(
          'message = ${message.notification?.title} : ${message.notification?.body}');
    }
    showNotificationAlert(message);
  }
}
