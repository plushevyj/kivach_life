import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

import '../repository/local_authentication_repository_impl.dart';
import '/widgets/alerts.dart';

part 'local_authentication_event.dart';
part 'local_authentication_state.dart';

class LocalAuthenticationBloc
    extends Bloc<LocalAuthenticationEvent, LocalAuthenticationState> {
  LocalAuthenticationBloc() : super(const LocalAuthenticationInitialState()) {
    on<LogOutLocally>(_onLogOutLocally);
    on<LogInLocallyUsingBiometrics>(_onLogInLocallyUsingBiometrics);
    on<LogInLocallyUsingDigitalPassword>(_onLogInLocallyUsingPassword);
  }

  final _localAuthentication = const LocalAuthenticationRepository();

  Future<void> _onLogOutLocally(
    LogOutLocally event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    final authenticationSetting =
        await _localAuthentication.checkAuthenticationSettings();
    if (authenticationSetting.$1) {
      emit(LocallyNotAuthenticated(authenticationSetting));
    } else {
      emit(const LocallyAuthenticated());
    }
  }

  Future<void> _onLogInLocallyUsingBiometrics(
    LogInLocallyUsingBiometrics event,
    Emitter<LocalAuthenticationState> emit,
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
              availableBiometrics.contains(BiometricType.iris) ||
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
      if (kDebugMode) {
        print('Ошибка аутентификации: $error');
      }
      showErrorAlert('Ошибка аутентификации');
    } catch (error) {
      if (kDebugMode) {
        print('Ошибка аутентификации: $error');
      }
      showErrorAlert('Ошибка аутентификации');
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        final authenticationSetting =
            await _localAuthentication.checkAuthenticationSettings();
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
      var enteredPasswordHash =
          sha256.convert(utf8.encode(event.password)).toString();
      final passwordSetting =
          await _localAuthentication.getLocalPasswordSetting();
      if (enteredPasswordHash == passwordSetting.hash) {
        isLocalAuthorized = true;
      } else {
        showErrorAlert('Неверный пароль');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      showErrorAlert(error.toString());
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        final authenticationSetting =
            await _localAuthentication.checkAuthenticationSettings();
        emit(LoadingLocalAuthentication(authenticationSetting));
        emit(LocallyNotAuthenticated(authenticationSetting));
      }
    }
  }
}
