import '/models/local_authentication_settings_model/biometric_setting_model.dart';

abstract class LocalAuthenticationRepository {
  Future<BiometricSettings> checkSettings();

  Future<BiometricSettings> getSettings();
}
