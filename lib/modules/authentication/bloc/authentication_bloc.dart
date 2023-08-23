import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/http/http.dart';
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
    on<AuthenticateByToken>(_onAuthenticateByToken);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAuthenticateByToken(
    AuthenticateByToken event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        emit(const Unauthenticated());
        return;
      }
      addAccessToken(accessToken: accessToken);
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
      tokenRepository.saveToken(token: token);
      addAccessToken(accessToken: token.token);
      final profile = await loginRepository.logInByToken();
      emit(const Authenticated());
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
