import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/utils/convert_to.dart';
import '../../../models/configuration_models/configuration_of_app/configuration_of_app.dart';

class ConfigurationOfAppRepository {
  const ConfigurationOfAppRepository();

  Future<ConfigurationOfApp> getConfigurationOfApp() async {
    final response =
        await handleRequest(() => Dio().get(dotenv.get('CONFIG_URL')));
    return ConvertTo<ConfigurationOfApp>()
        .item(response.data, ConfigurationOfApp.fromJson);
  }
}
