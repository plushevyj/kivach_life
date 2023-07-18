import 'package:doctor/models/local_authentication_settings_model/biometric_setting_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'local_authentication_repository.dart';
import '/models/local_password_model/local_password_model.dart';

class NewLocalPasswordRepositoryImpl implements NewLocalPasswordRepository {
  const NewLocalPasswordRepositoryImpl();

  Future<Box<dynamic>> _openStorage() async {
    return await Hive.openBox('localAuthenticationSettings');
  }

  Future<void> _closeStorage() async {
    await Hive.box('localAuthenticationSettings').close();
  }

  @override
  Future<void> savePassword(LocalPassword localPassword) async {
    final box = await _openStorage();
    await box.putAt(0, localPassword);
    await _closeStorage();
  }

  @override
  Future<void> saveBiometricSetting(BiometricSettings biometricSettings) async {
    final box = await _openStorage();
    await box.putAt(1, biometricSettings);
    final kek = box.getAt(1) as BiometricSettings;
    print(kek.isBiometricSecurity);
  }
}
