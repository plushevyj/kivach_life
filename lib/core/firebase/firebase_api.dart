import 'package:firebase_messaging/firebase_messaging.dart';

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
    FirebaseMessaging.onMessage.listen((message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      showNotificationAlert(message);
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
