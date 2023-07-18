import 'package:doctor/models/local_authentication_settings_model/biometric_setting_model.dart';

import '/models/local_password_model/local_password_model.dart';

abstract class NewLocalPasswordRepository {
  Future<void> savePassword(LocalPassword localPassword);
  Future<void> saveBiometricSetting(BiometricSettings biometricSettings);
}
