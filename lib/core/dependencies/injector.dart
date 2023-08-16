import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../http/http.dart';
import '/models/biometric_settings_model/biometric_setting_model.dart';
import '/models/local_password_model/local_password_model.dart';
import 'observer.dart';

Future<void> initializeDependencies() async {
  // Get.smartManagement = SmartManagement.full;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BiometricSettingsAdapter())
    ..registerAdapter(LocalPasswordAdapter());
  GetIt.I.registerSingleton<Dio>(const Http().createClient());
}
