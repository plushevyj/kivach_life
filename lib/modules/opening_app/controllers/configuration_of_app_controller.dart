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
    GetIt.I.registerSingleton<Dio>(DioClient().dio);
    super.onInit();
  }
}
