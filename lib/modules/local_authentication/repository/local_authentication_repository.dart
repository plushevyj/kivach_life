import '../models/local_authentication_settings_model/local_authentication_settings_model.dart';

abstract class LocalAuthenticationRepository {
  Future<LocalAuthenticationSettings> checkSettings();

  Future<LocalAuthenticationSettings> getSettings();
}
