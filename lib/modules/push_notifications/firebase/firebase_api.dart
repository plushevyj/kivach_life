import 'package:doctor/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../opening_app/controllers/configuration_of_app_controller.dart';
import '/modules/push_notifications/repository/push_notifications_repository.dart';
import '/widgets/alerts.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static RemoteMessage? initialMessage;

  Future<void> initNotifications() async {
    initialMessage = await _firebaseMessaging.getInitialMessage();
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
    //когда приложение открыто
    FirebaseMessaging.onMessage.listen((message) async {
      print('message = ${message.data}');
      if (GetPlatform.isAndroid) {
        showNotificationAlert(
          title: message.notification?.title,
          message: message.notification?.body,
          onMainButtonPressed: () {
            routeFromPayload(message);
          },
        );
      }
    });
    //когда приложение свернуто
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      routeFromPayload(message);
    });
  }

  static void routeFromPayload(RemoteMessage message) async {
    try {
      final urlFromPayload = message.data['url'];
      final route = urlFromPayload.split(
          Get.find<ConfigurationOfAppController>()
              .configuration
              .value
              ?.BASE_URL)[1];
      Get.find<ConfigurationOfAppController>().payloadRoute.value = route;
      if (Get.context!.read<LocalAuthenticationBloc>().state
          is LocallyAuthenticated) {
        Get.until((route) => Get.currentRoute == '/home');
      }
    } catch (_) {}
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
