import 'package:firebase_core/firebase_core.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../modules/push_notifications/firebase/firebase_api.dart';
import '/firebase_options.dart';
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
  await [
    Permission.camera,
    Permission.photos,
  ].request();
  await FkUserAgent.init();
}
