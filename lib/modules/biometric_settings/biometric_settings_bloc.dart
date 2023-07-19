import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

import '../../models/biometric_settings_model/biometric_setting_model.dart';
import '../../widgets/alerts.dart';
import '../local_authentication/repository/local_authentication_repository_impl.dart';

part 'biometric_settings_event.dart';
part 'biometric_settings_state.dart';

class BiometricSettingsBloc
    extends Bloc<BiometricSettingsEvent, BiometricSettingsState> {
  BiometricSettingsBloc() : super(const BiometricSettingsInitial()) {
    on<CheckUser>(_onCheckUser);
  }

  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  Future<void> _onCheckUser(
    CheckUser event,
    Emitter<BiometricSettingsState> emit,
  ) async {
    var canCheckBiometric = false;
    var availableBiometrics = <BiometricType>[];
    var isLocalAuthorized = false;
    try {
      final localAuthenticationSetting =
          await _localAuthenticationRepository.checkAuthenticationSettings();
      if (localAuthenticationSetting.$1 == false) {
        throw 'Необходимо создать пароль для входа в приложение';
      }
      final localAuthentication = LocalAuthentication();
      canCheckBiometric = await localAuthentication.canCheckBiometrics;
      availableBiometrics = await localAuthentication.getAvailableBiometrics();
      if (canCheckBiometric &&
          (availableBiometrics.contains(BiometricType.strong) ||
              availableBiometrics.contains(BiometricType.face) ||
              availableBiometrics.contains(BiometricType.fingerprint))) {
        isLocalAuthorized = await localAuthentication.authenticate(
          localizedReason: 'Аутентификация в приложении Kivach life',
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
            sensitiveTransaction: false,
            biometricOnly: true,
          ),
        );
        if (isLocalAuthorized) {
          await _localAuthenticationRepository.saveBiometricSetting(
              BiometricSettings(isBiometricSecurity: true));
        }
      }
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print('Биометрические данные не подтверждены: $error');
      }
      showErrorAlert('Биометрические данные не подтверждены');
    } catch (error) {
      if (kDebugMode) {
        print('Биометрические данные не подтверждены: $error');
      }
      showErrorAlert(error.toString());
    } finally {
      if (isLocalAuthorized) {
        emit(const ValidUserBiometricData());
        showSuccessAlert('Вход в приложение по биометрическим данным включен');
      } else {
        emit(const InvalidUserBiometricData());
      }
    }
  }
}
