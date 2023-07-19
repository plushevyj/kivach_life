import 'package:hive_flutter/hive_flutter.dart';

part 'biometric_setting_model.g.dart';

@HiveType(typeId: 0)
class BiometricSettings extends HiveObject {
  BiometricSettings({required this.isBiometricSecurity});

  @HiveField(0, defaultValue: false)
  bool isBiometricSecurity;
}
