import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

import '../../../models/biometric_settings_model/biometric_setting_model.dart';
import '../../../models/local_password_model/local_password_model.dart';


class LocalAuthenticationRepository {
  const LocalAuthenticationRepository();

  Future<Box<dynamic>> _openLocalPasswordStorage() async {
    return await Hive.openBox<LocalPassword>('localAuthenticationSettings');
  }

  Future<Box<dynamic>> _openBiometricSettingStorage() async {
    return await Hive.openBox<BiometricSettings>('biometricSetting');
  }

  Future<(bool, bool)> checkLocalAuthenticationSettings() async {
    final localPasswordBox = await _openLocalPasswordStorage();
    final isLocalPassword = (() {
      if (localPasswordBox.isNotEmpty) {
        final localPasswordSetting = localPasswordBox.getAt(0) as LocalPassword;
        return localPasswordSetting.hash != null;
      } else {
        return false;
      }
    }());
    final biometricSettingBox = await _openBiometricSettingStorage();
    final isBiometricSetting = (() {
      if (biometricSettingBox.isNotEmpty) {
        final biometricSetting =
            biometricSettingBox.getAt(0) as BiometricSettings;
        return biometricSetting.isBiometricSecurity;
      } else {
        return false;
      }
    }());
    return (isLocalPassword, isBiometricSetting);
  }

  Future<LocalPassword> getLocalPasswordSetting() async {
    final box = await _openLocalPasswordStorage();
    final localPasswordSetting = await box.getAt(0) as LocalPassword;
    return localPasswordSetting;
  }

  Future<BiometricSettings> getBiometricSetting() async {
    final box = await _openBiometricSettingStorage();
    final biometricSettings = await box.getAt(0) as BiometricSettings;
    return biometricSettings;
  }

  Future<void> savePassword(LocalPassword localPassword) async {
    final box = await _openLocalPasswordStorage();
    if (box.isEmpty) {
      await box.add(localPassword);
    } else {
      await box.putAt(0, localPassword);
    }
  }

  Future<void> saveBiometricSetting(BiometricSettings biometricSettings) async {
    final box = await _openBiometricSettingStorage();
    if (box.isEmpty) {
      await box.add(biometricSettings);
    } else {
      await box.putAt(0, biometricSettings);
    }
  }

  Future<bool> authenticateByBiometric() async {
    var canCheckBiometric = false;
    var availableBiometrics = <BiometricType>[];
    var isLocalAuthenticated = false;
    final localAuthentication = LocalAuthentication();
    canCheckBiometric = await localAuthentication.canCheckBiometrics;
    availableBiometrics = await localAuthentication.getAvailableBiometrics();
    if (canCheckBiometric &&
        (availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.face) ||
            availableBiometrics.contains(BiometricType.iris) ||
            availableBiometrics.contains(BiometricType.fingerprint))) {
      isLocalAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Приложение KivachLive',
        authMessages: [
          const AndroidAuthMessages(
            biometricHint: '',
            signInTitle: 'Подтвердите личность',
          ),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
          sensitiveTransaction: false,
          biometricOnly: true,
        ),
      );
    }
    return isLocalAuthenticated;
  }

  Future<void> deleteLocalPassword() async {
    final box = await _openLocalPasswordStorage();
    if (box.isNotEmpty) {
      await box.deleteAt(0);
    }
  }

  Future<void> deleteBiometricSetting() async {
    final box = await _openBiometricSettingStorage();
    if (box.isNotEmpty) {
      await box.deleteAt(0);
    }
  }
}
