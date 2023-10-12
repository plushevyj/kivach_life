import 'package:dio/dio.dart';
import 'package:doctor/models/configuration_models/configuration_of_app/configuration_of_app.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/http.dart';
import '../repository/configuration_of_app_repository.dart';

class ConfigurationOfAppController extends GetxController {
  late Rx<ConfigurationOfApp> configuration;

  @override
  void onInit() async {
    configuration =
        (await const ConfigurationOfAppRepository().getConfigurationOfApp())
            .obs;
    print('configuration.value.BASE_URL1 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL2 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL3 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL4 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL5 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL6 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL7 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL8 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL9 = ${configuration.value.BASE_URL}');
    print('configuration.value.BASE_URL0 = ${configuration.value.BASE_URL}');
    GetIt.I.registerSingleton<Dio>(DioClient().dio);
    super.onInit();
  }
}
