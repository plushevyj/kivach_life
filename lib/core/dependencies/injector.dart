import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/biometric_settings_model/biometric_setting_model.dart';
import '../../models/local_password_model/local_password_model.dart';
import 'observer.dart';

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BiometricSettingsAdapter())
    ..registerAdapter(LocalPasswordAdapter());
}
