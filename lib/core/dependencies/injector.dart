import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'observer.dart';

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  await Hive.initFlutter();
}
