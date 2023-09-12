import 'package:doctor/widgets/alerts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
    print('token = ${fCMToken.toString()}');
  }

  void _handleMessage(RemoteMessage message) {
    print('message = ${message.notification?.title}');
    showNotificationAlert(message);
  }
}
