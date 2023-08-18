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
    on<AuthenticationAppStarted>(_onAuthenticationAppStarted);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAuthenticationAppStarted(
    AuthenticationAppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      // emit(const Authenticated());
      // return;
      emit(const AuthenticationLoading());
      final token = await tokenRepository.getAccessToken();
      if (token == null) {
        emit(const Unauthenticated());
        return;
      }
      tokenRepository.addAccessToken(token);
      final player = await loginRepository.logInByToken();
      // Get.put(AuthController(), permanent: true).account.value = player;
      emit(const Authenticated());
    } catch (error) {
      print(error);
      emit(AuthenticationError(error.toString()));
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLogIn(
    LogIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final token = await loginRepository.logIn(
        username: event.username,
        password: event.password,
      );
      emit(const Authenticated());
      // Get.put(AuthController(), permanent: true).account.value = player;
      // tokenRepository.addToken(token.token);
      // tokenRepository.saveToken(token.token);
    } catch (error) {
      print(error);
      emit(AuthenticationError(error.toString()));
      emit(const Unauthenticated());
      // Get.put(AuthController(), permanent: true).passwordErrorText.value =
      //     'Некорректная почта или пароль';
    }
  }

  Future<void> _onLogOut(
      LogOut event, Emitter<AuthenticationState> emit) async {
    await tokenRepository.clearTokens();
    emit(const Unauthenticated());
  }
}
