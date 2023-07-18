import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

import '../../widgets/alerts.dart';

part 'biometric_settings_event.dart';
part 'biometric_settings_state.dart';

class BiometricSettingsBloc
    extends Bloc<BiometricSettingsEvent, BiometricSettingsState> {
  BiometricSettingsBloc() : super(const BiometricSettingsInitial()) {
    on<CheckUser>(_onCheckUser);
  }

  Future<void> _onCheckUser(
    CheckUser event,
    Emitter<BiometricSettingsState> emit,
  ) async {
    var canCheckBiometric = false;
    var availableBiometrics = <BiometricType>[];
    var isLocalAuthorized = false;
    try {
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
      }
    } on PlatformException catch (error) {
      print('Биометрические данные не подтверждены: $error');
      showErrorAlert('Биометрические данные не подтверждены');
    } catch (error) {
      print('Биометрические данные не подтверждены: $error');
      showErrorAlert('Биометрические данные не подтверждены');
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
