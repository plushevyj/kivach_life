import 'package:dio/dio.dart';
import 'package:doctor/core/firebase/firebase_api.dart';
import 'package:doctor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../http/http.dart';
import '/models/biometric_settings_model/biometric_setting_model.dart';
import '/models/local_password_model/local_password_model.dart';
import 'observer.dart';

Future<void> initializeDependencies() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await dotenv.load();
  Bloc.observer = Observer();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BiometricSettingsAdapter())
    ..registerAdapter(LocalPasswordAdapter());
  GetIt.I.registerSingleton<Dio>(DioClient().dio);
  await [Permission.camera, Permission.photos, Permission.storage].request();
}
