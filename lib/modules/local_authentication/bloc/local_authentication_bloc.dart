import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../repository/local_authentication_repository.dart';
import '/widgets/alerts.dart';

part 'local_authentication_event.dart';
part 'local_authentication_state.dart';

class LocalAuthenticationBloc
    extends Bloc<LocalAuthenticationEvent, LocalAuthenticationState> {
  LocalAuthenticationBloc() : super(const LocalAuthenticationInitialState()) {
    on<LocallyAuthStarted>(_onLocallyAuthStarted);
    on<LogInLocallyUsingBiometrics>(_onLogInLocallyUsingBiometrics);
    on<LogInLocallyUsingDigitalPassword>(_onLogInLocallyUsingPassword);
  }

  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  Future<void> _onLocallyAuthStarted(
    LocallyAuthStarted event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    final canAuthenticateByBiometric =
        await _localAuthenticationRepository.canAuthenticateByBiometric();
    var localAuthSettings =
        await _localAuthenticationRepository.checkLocalAuthenticationSettings();
    if (!canAuthenticateByBiometric && localAuthSettings.$2) {
      _localAuthenticationRepository.deleteBiometricSetting();
      localAuthSettings = (localAuthSettings.$1, false);
    }
    if (localAuthSettings.$1) {
      emit(LocallyNotAuthenticated(localAuthSettings));
    } else {
      await Get.toNamed('/onboarding_settings');
      emit(const LocallyAuthenticated());
    }
  }

  Future<void> _onLogInLocallyUsingBiometrics(
    LogInLocallyUsingBiometrics event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    var isLocalAuthorized = false;
    try {
      final biometricSetting =
          await _localAuthenticationRepository.getBiometricSetting();
      if (biometricSetting?.isBiometricSecurity ?? false) {
        isLocalAuthorized =
            await _localAuthenticationRepository.authenticateByBiometric();
      }
    } on PlatformException catch (_) {
    } catch (_) {
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        final authenticationSetting = await _localAuthenticationRepository
            .checkLocalAuthenticationSettings();
        emit(LocallyNotAuthenticated(authenticationSetting));
      }
    }
  }

  Future<void> _onLogInLocallyUsingPassword(
    LogInLocallyUsingDigitalPassword event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var isLocalAuthorized = false;
    try {
      final enteredPasswordHash =
          sha256.convert(utf8.encode(event.password)).toString();
      final passwordSetting =
          await _localAuthenticationRepository.getLocalPasswordSetting();
      if (enteredPasswordHash == passwordSetting?.hash) {
        isLocalAuthorized = true;
      } else {
        showErrorAlert('Неверный пароль');
      }
    } catch (error) {
      showErrorAlert(error.toString());
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        final authenticationSetting = await _localAuthenticationRepository
            .checkLocalAuthenticationSettings();
        emit(LoadingLocalAuthentication(authenticationSetting));
        emit(LocallyNotAuthenticated(authenticationSetting));
      }
    }
  }
}
