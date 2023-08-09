import 'dart:async';

import 'package:doctor/modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/biometric_settings_model/biometric_setting_model.dart';
import '../../../widgets/alerts.dart';
import '../../identity_proof/ui/identity_proof_ui.dart';
import '../../local_authentication/repository/local_authentication_repository.dart';

part 'biometric_settings_event.dart';
part 'biometric_settings_state.dart';

class BiometricSettingsBloc
    extends Bloc<BiometricSettingsEvent, BiometricSettingsState> {
  BiometricSettingsBloc({required this.localPasswordSettingBloc})
      : super(const BiometricSettingsInitial()) {
    on<EnableBiometricsLogin>(_enableBiometricsLogin);
    passwordSettingSubscription =
        localPasswordSettingBloc.stream.listen((state) {
      if (state is DeletedLocalPassword) {
        print('kekekekekekekke');
        add(const EnableBiometricsLogin(false));
        print('kekekekekekekke');
      }
    });
  }

  late final StreamSubscription passwordSettingSubscription;
  final LocalPasswordSettingBloc localPasswordSettingBloc;
  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  Future<void> _enableBiometricsLogin(
    EnableBiometricsLogin event,
    Emitter<BiometricSettingsState> emit,
  ) async {
    try {
      if (event.state) {
        final localAuthenticationSetting = await _localAuthenticationRepository
            .checkLocalAuthenticationSettings();
        if (!localAuthenticationSetting.$1) {
          throw 'Необходимо создать пароль для входа в приложение';
        }
        if (await identityProof()) {
          final isLocalAuthorized =
              await _localAuthenticationRepository.authenticateByBiometric();
          if (isLocalAuthorized) {
            await _localAuthenticationRepository.saveBiometricSetting(
                BiometricSettings(isBiometricSecurity: true));
            showSuccessAlert('Вход в приложение по биометрии включен');
            emit(const ChangedUserBiometricSetting(true));
          }
        }
      } else {
        if (await identityProof()) {
          await _localAuthenticationRepository.saveBiometricSetting(
              BiometricSettings(isBiometricSecurity: false));
          showSuccessAlert('Вход в приложение по биометрии выключен');
          emit(const ChangedUserBiometricSetting(false));
        }
      }
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      // showErrorAlert('Биометрические данные не подтверждены');
    } catch (error) {
      showErrorAlert(error.toString());
    }
  }

  @override
  Future<void> close() {
    passwordSettingSubscription.cancel();
    return super.close();
  }
}
