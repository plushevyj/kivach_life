import 'package:dio/dio.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart';

import '../../../core/http/request_handler.dart';
import '../../account/controllers/account_controller.dart';
import '../../opening_app/controllers/configuration_of_app_controller.dart';

// POST запрос на /api/log
// {
//     'key': 'zqrf4Fs',
//     'userName': '123',
//     'userAgent': 'fhjrfr',
//     'dateTime': '2024-06-03 12:00:00',
//     'text': 'sdfgdgbfdh'
// }

class LogsRepository {
  const LogsRepository();

  Future<void> sendLogs(String text) async {
    final path = '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}/api/log';

    String? userName;

    try {
      userName = Get.find<AccountController>().profile.value?.username;
    } catch (_) {}

    final appVersion = (await PackageInfo.fromPlatform()).version;
    final userAgent =
        '${FkUserAgent.userAgent ?? 'Unknown'} KivachLife/$appVersion';

    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDateTime = formatter.format(now);

    final data = {
      'key': 'zqrf4Fs',
      'userName': userName ?? '',
      'userAgent': userAgent,
      'dateTime': formattedDateTime,
      'text': text,
    };

    await handleRequest(
      () => Dio().post(
        path,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ),
    );
  }
}
