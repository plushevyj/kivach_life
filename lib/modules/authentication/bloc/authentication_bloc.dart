import 'dart:async';

import 'package:dio/dio.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../core/http/http.dart';
import '../../first_opening_app/repository/first_opening_app_repository.dart';
import '../../local_authentication/repository/local_authentication_repository.dart';
import '../repository/login_repository.dart';
import '../repository/token_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository loginRepository;
  final TokenRepository tokenRepository;
  final LocalAuthenticationRepository localAuthenticationRepository;

  AuthenticationBloc({
    this.loginRepository = const LoginRepository(),
    this.tokenRepository = const TokenRepository(),
    this.localAuthenticationRepository = const LocalAuthenticationRepository(),
  }) : super(const AuthenticationInitial()) {
    on<AuthenticateByToken>(_onAuthenticateByToken);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAuthenticateByToken(
    AuthenticateByToken event,
    Emitter<AuthenticationState> emit,
  ) async {
    const firstOpeningOfAppRepository = FirstOpeningOfAppRepository();
    final isFirstOpening =
        await firstOpeningOfAppRepository.checkFirstOpening();
    if (isFirstOpening) {
      await Get.toNamed('/onboarding_greeting');
      await firstOpeningOfAppRepository.saveFirstOpeningSetting(false);
    }
    // try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        emit(const Unauthenticated());
        return;
      }
      addAccessToken(accessToken: accessToken);
      final profile = await loginRepository.logInByToken();
      emit(const Authenticated());
    // } catch (error) {
    //   emit(AuthenticationError(error.toString()));
    //   tokenRepository.clearTokens();
    //   localAuthenticationRepository
    //     ..deleteBiometricSetting()
    //     ..deleteLocalPassword();
    //   emit(const Unauthenticated());
    // }
  }

  Future<void> _onLogIn(
    LogIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(const AuthenticationLoading());
      final token = await loginRepository.logIn(
        username: event.username,
        password: event.password,
      );
      tokenRepository.saveToken(token: token);
      addAccessToken(accessToken: token.token);
      final profile = await loginRepository.logInByToken();
      emit(const Authenticated());
    } catch (error) {
      emit(AuthenticationError(error.toString()));
      showErrorAlert(error.toString());
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLogOut(
      LogOut event, Emitter<AuthenticationState> emit) async {
    await tokenRepository.clearTokens();
    emit(const Unauthenticated());
  }
}
