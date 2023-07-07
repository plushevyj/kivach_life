import 'dart:async';

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
  final _localAuthentication = const LocalAuthenticationRepositoryImpl();

  LocalAuthenticationBloc() : super(const LocallyNotAuthenticated()) {
    on<LogOutLocally>(_onLogOutLocally);
    on<LogInLocallyUsingBiometrics>(_onLogInLocallyUsingBiometrics);
    on<LogInLocallyUsingDigitalPassword>(_onLogInLocallyUsingPassword);
  }

  Future<void> _onLogOutLocally(
    LogOutLocally event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    emit(const LocallyNotAuthenticated());
  }

  Future<void> _onLogInLocallyUsingBiometrics(
    LogInLocallyUsingBiometrics event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    emit(const LoadingLocalAuthentication());
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
      print('Ошибка аутентификации: $error');
      showError('Ошибка аутентификации');
    } catch (error) {
      print('Ошибка аутентификации: $error');
      showError('Ошибка аутентификации');
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        emit(const LocallyNotAuthenticated());
      }
    }
  }

  Future<void> _onLogInLocallyUsingPassword(
    LogInLocallyUsingDigitalPassword event,
    Emitter<LocalAuthenticationState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const LoadingLocalAuthentication());
    var isLocalAuthorized = false;
    try {
      if (event.password == '4355') {
        isLocalAuthorized = true;
      }
    } catch (error) {
      showError('Ошибка аутентификации');
    } finally {
      if (isLocalAuthorized) {
        emit(const LocallyAuthenticated());
      } else {
        emit(const LocallyNotAuthenticated());
      }
    }
  }
}
