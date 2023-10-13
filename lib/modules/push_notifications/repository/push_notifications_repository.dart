import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '/core/http/request_handler.dart';

class PushNotificationsRepository {
  const PushNotificationsRepository();

  static final _dio = GetIt.I.get<Dio>();

  Future<void> setTokenPushNotifications({
    required String token,
  }) async {
    final data = {'token': token};
    await Clipboard.setData(ClipboardData(text: token));
    await handleRequest(
      () => _dio.post(
        '/api/push-token/set',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'User-Agent': FkUserAgent.userAgent ?? 'Unknown',
          },
        ),
      ),
    );
  }
}
