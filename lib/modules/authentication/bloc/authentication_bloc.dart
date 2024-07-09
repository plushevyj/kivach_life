import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../core/http/http.dart';
import '../../../pages/auth_page/auth_page.dart';
import '../../../pages/onboarding_greeting_page/onboarding_greeting_page.dart';
import '../../account/controllers/account_controller.dart';
import '../../local_authentication/bloc/local_authentication_bloc.dart';
import '../../local_authentication/repository/local_authentication_repository.dart';
import '../../logs/repository/logs_repository.dart';
import '../../opening_app/repository/first_opening_app_repository.dart';
import '../repository/login_repository.dart';
import '../repository/token_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository loginRepository;
  final TokenRepository tokenRepository;
  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  AuthenticationBloc({
    this.loginRepository = const LoginRepository(),
    this.tokenRepository = const TokenRepository(),
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
      await Get.toNamed(GreetingOnboardingPage.route);
      await firstOpeningOfAppRepository.saveFirstOpeningSetting(false);
    }
    try {
      final accessToken = await tokenRepository.getAccessToken();

      const LogsRepository().sendLogs(json.encode({
        'event': 'Get access token from local storage',
        'accessToken': accessToken,
        'place': 'lib/modules/authentication/bloc/authentication_bloc.dart:51',
      }));

      if (accessToken == null) {
        emit(const Unauthenticated());
        _localAuthenticationRepository
          ..deleteLocalPassword()
          ..deleteBiometricSetting();
        return;
      }
      addAccessTokenInHTTPClient();
      final profile = await loginRepository.getProfile();
      Get.put(AccountController(), permanent: true).profile(profile);
      emit(const Authenticated());
    } catch (error) {
      emit(AuthenticationError(error.toString()));
      tokenRepository.clearTokens();
      emit(const Unauthenticated());
      _localAuthenticationRepository
        ..deleteLocalPassword()
        ..deleteBiometricSetting();
    }
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

      const LogsRepository().sendLogs(json.encode({
        'event': 'Login by using username',
        'accessToken': token.token,
        'refreshToken': token.refresh_token,
        'place': 'lib/modules/authentication/bloc/authentication_bloc.dart:89',
      }));

      tokenRepository.saveTokens(token: token);
      await addAccessTokenInHTTPClient();
      final profile = await loginRepository.getProfile();
      Get.put(AccountController(), permanent: true).profile(profile);
      emit(const Authenticated());
    } catch (error) {
      emit(AuthenticationError(error.toString()));
      tokenRepository.clearTokens();
      emit(const Unauthenticated());
      _localAuthenticationRepository
        ..deleteLocalPassword()
        ..deleteBiometricSetting();
    }
  }

  Future<void> _onLogOut(
      LogOut event, Emitter<AuthenticationState> emit) async {
    try {
      await loginRepository.logOut();
    } catch (_) {}
    await tokenRepository.clearTokens();
    emit(const Unauthenticated());
    _localAuthenticationRepository
      ..deleteLocalPassword()
      ..deleteBiometricSetting();
  }
}

void logOut() {
  Get.delete<AccountController>(force: true);
  Get.context!.read<LocalAuthenticationBloc>().add(const LocallyLogOut());
  Get.context!.read<AuthenticationBloc>().add(const LogOut());
  Get.offAllNamed(AuthorizationPage.route);
}
