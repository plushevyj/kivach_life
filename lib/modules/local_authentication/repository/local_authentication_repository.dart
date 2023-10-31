import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LocalAuthenticationKeyStore {
  _LocalAuthenticationKeyStore._();

  static const String isBiometricSecurity = 'isBiometricSecurity';
  static const String localPasswordHash = 'localPasswordHash';
}

class LocalAuthenticationRepository {
  const LocalAuthenticationRepository();

  Future<(bool, bool)> checkLocalAuthenticationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isLocalPassword =
        prefs.getString(_LocalAuthenticationKeyStore.localPasswordHash) != null;
    final isBiometricSetting =
        prefs.getBool(_LocalAuthenticationKeyStore.isBiometricSecurity) ??
            false;
    return (isLocalPassword, isBiometricSetting);
  }

  Future<String?> getLocalPasswordHash() async {
    return (await SharedPreferences.getInstance())
        .getString(_LocalAuthenticationKeyStore.localPasswordHash);
  }

  Future<bool> getBiometricSetting() async {
    return (await SharedPreferences.getInstance())
            .getBool(_LocalAuthenticationKeyStore.isBiometricSecurity) ??
        false;
  }

  Future<void> savePassword({required String hash}) async {
    (await SharedPreferences.getInstance())
        .setString(_LocalAuthenticationKeyStore.localPasswordHash, hash);
  }

  Future<void> saveBiometricSetting({required bool isBiometricSecurity}) async {
    (await SharedPreferences.getInstance()).setBool(
        _LocalAuthenticationKeyStore.isBiometricSecurity, isBiometricSecurity);
  }

  Future<bool> authenticateByBiometric() async {
    var canCheckBiometric = false;
    var availableBiometrics = <BiometricType>[];
    var isLocalAuthenticated = false;
    final localAuthentication = LocalAuthentication();
    canCheckBiometric = await localAuthentication.canCheckBiometrics;
    availableBiometrics = await localAuthentication.getAvailableBiometrics();
    if (canCheckBiometric && availableBiometrics.isNotEmpty) {
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
    (await SharedPreferences.getInstance())
        .remove(_LocalAuthenticationKeyStore.localPasswordHash);
  }

  Future<void> deleteBiometricSetting() async {
    (await SharedPreferences.getInstance())
        .remove(_LocalAuthenticationKeyStore.isBiometricSecurity);
  }

  Future<bool> canAuthenticateByBiometric() async {
    final localAuthentication = LocalAuthentication();
    final canCheckBiometric = await localAuthentication.canCheckBiometrics;
    final availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    return canCheckBiometric && availableBiometrics.isNotEmpty;
  }
}
