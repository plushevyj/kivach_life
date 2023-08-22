import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../first_opening_app/controller/first_opening_app_controller.dart';
import '../repository/login_repository.dart';
import '../repository/token_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository loginRepository;
  final TokenRepository tokenRepository;

  AuthenticationBloc({
    this.loginRepository = const LoginRepository(),
    this.tokenRepository = const TokenRepository(),
  }) : super(const AuthenticationInitial()) {
    on<AuthenticateByToken>(_onAuthenticationAppStarted);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAuthenticationAppStarted(
    AuthenticateByToken event,
    Emitter<AuthenticationState> emit,
  ) async {
    // emit(const Unauthenticated());
    // return;
    try {
      final token = await tokenRepository.getAccessToken();
      if (token == null) {
        emit(const Unauthenticated());
        return;
      }
      tokenRepository.addAccessToken(token);
      final profile = await loginRepository.logInByToken();
      emit(const Authenticated());
    } catch (error) {
      emit(AuthenticationError(error.toString()));
      emit(const Unauthenticated());
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
      print('token = $token');
      emit(const Authenticated());
      tokenRepository.addAccessToken(token.token);
      tokenRepository.saveTokens(
          accessToken: token.token, refreshTokens: token.refresh_token);
    } catch (error) {
      emit(AuthenticationError(error.toString()));
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLogOut(
      LogOut event, Emitter<AuthenticationState> emit) async {
    await tokenRepository.clearTokens();
    emit(const Unauthenticated());
  }
}
