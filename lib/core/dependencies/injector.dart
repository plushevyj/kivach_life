import 'package:firebase_core/firebase_core.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firebase/firebase_api.dart';
import '/firebase_options.dart';
import '/models/biometric_settings_model/biometric_setting_model.dart';
import '/models/local_password_model/local_password_model.dart';
import 'observer.dart';

Future<void> initializeDependencies() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    name: 'kivach-life',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await dotenv.load();
  Bloc.observer = Observer();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BiometricSettingsAdapter())
    ..registerAdapter(LocalPasswordAdapter());
  await [
    Permission.camera,
    Permission.photos,
    Permission.storage,
    Permission.manageExternalStorage
  ].request();
  await FkUserAgent.init();
  await FlutterDownloader.initialize();
}
