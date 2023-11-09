import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/modules/local_password_settings/bloc/local_password_settings_bloc.dart';
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
        add(const EnableBiometricsLogin(false));
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
      final localAuthenticationSetting = await _localAuthenticationRepository
          .checkLocalAuthenticationSettings();
      if (event.state) {
        if (!localAuthenticationSetting.$1) {
          throw 'Необходимо создать пароль для входа в приложение';
        }
        if (await identityProof(password: event.proof)) {
          final isLocalAuthorized =
              await _localAuthenticationRepository.authenticateByBiometric();
          if (isLocalAuthorized) {
            await _localAuthenticationRepository.saveBiometricSetting(
                isBiometricSecurity: true);
            emit(const ChangedUserBiometricSetting(true));
          }
        }
      } else {
        if (await identityProof() && localAuthenticationSetting.$2) {
          await _localAuthenticationRepository.saveBiometricSetting(
              isBiometricSecurity: false);
          emit(const ChangedUserBiometricSetting(false));
        }
      }
    } on PlatformException catch (_) {
    } catch (error) {
      if (kDebugMode) {
        print('error: ${error.toString()}');
      }
      emit(ErrorBiometricSettings(error.toString()));
    } finally {
      emit(const BiometricSettingsInitial());
    }
  }

  @override
  Future<void> close() {
    passwordSettingSubscription.cancel();
    return super.close();
  }
}
