import 'package:hive_flutter/hive_flutter.dart';

import '../models/local_authentication_settings_model/local_authentication_settings_model.dart';
import 'local_authentication_repository.dart';

class LocalAuthenticationRepositoryImpl
    implements LocalAuthenticationRepository {
  const LocalAuthenticationRepositoryImpl();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox('localAuthenticationSettings');
  }

  Future<void> _closeStorage() async {
    await Hive.box('localAuthenticationSettings').close();
  }

  @override
  Future<bool> checkSettings() async {
    final storage = await _openStorage();

    storage.add(LocalAuthenticationSettings(
        isLocalPassword: true, isBiometricSecurity: true));
    return storage.isEmpty;
  }

  @override
  Future<LocalAuthenticationSettings> getSettings() async {
    final storage = await _openStorage();
    return storage.getAt(0);
  }
}
