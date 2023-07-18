import 'package:hive_flutter/hive_flutter.dart';

import '/models/local_authentication_settings_model/biometric_setting_model.dart';
import 'local_authentication_repository.dart';

class LocalAuthenticationRepositoryImpl
    implements LocalAuthenticationRepository {
  const LocalAuthenticationRepositoryImpl();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox<BiometricSettings>(
        'localAuthenticationSettings');
  }

  Future<void> _closeStorage() async {
    await Hive.box('localAuthenticationSettings').close();
  }

  @override
  Future<BiometricSettings> checkSettings() async {
    final storage = await _openStorage();
    print(storage.length);
    if (storage.length > 1) {
      throw Exception('HiveBox \'localAuthenticationSettings\' must have a length that is 1.');
    }

    return storage.getAt(0);
  }

  @override
  Future<BiometricSettings> getSettings() async {
    final storage = await _openStorage();
    return storage.getAt(0);
  }
}
