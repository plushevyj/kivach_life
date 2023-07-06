import 'package:hive_flutter/hive_flutter.dart';

part 'local_authentication_settings_model.g.dart';

@HiveType(typeId: 0)
class LocalAuthenticationSettings extends HiveObject {
  LocalAuthenticationSettings(
      {required this.isLocalPassword, required this.isBiometricSecurity})
      : assert(
          !(isLocalPassword == false && isBiometricSecurity == true),
          'Biometric authentication is possible together '
          'with digital password authentication.',
        );

  @HiveField(0, defaultValue: false)
  bool isLocalPassword;

  @HiveField(1, defaultValue: false)
  bool isBiometricSecurity;
}
