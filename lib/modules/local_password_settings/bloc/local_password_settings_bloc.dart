import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/modules/identity_proof/ui/identity_proof_ui.dart';
import '/modules/local_authentication/repository/local_authentication_repository.dart';
import '/widgets/alerts.dart';

part 'local_password_settings_event.dart';
part 'local_password_settings_state.dart';

class LocalPasswordSettingBloc
    extends Bloc<LocalPasswordSettingEvent, LocalPasswordSettingState> {
  LocalPasswordSettingBloc()
      : super(const LocalPasswordSettingsInitialState()) {
    on<LocalPasswordSettingsInitialEvent>(_onNewLocalPasswordEventInitial);
    on<CreatePassword>(_onCreatePassword);
    on<EnterFirstLocalPassword>(_onEnterFirstLocalPassword);
    on<EnterSecondLocalPassword>(_onEnterSecondLocalPassword);
    on<DeleteLocalPassword>(_onDeleteLocalPassword);
  }

  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  String? _firstPassword;

  void _onNewLocalPasswordEventInitial(
    LocalPasswordSettingsInitialEvent event,
    Emitter<LocalPasswordSettingState> emit,
  ) {
    emit(const LocalPasswordSettingsInitialState());
  }

  void _onCreatePassword(
    CreatePassword event,
    Emitter<LocalPasswordSettingState> emit,
  ) async {
    try {
      _firstPassword = null;
      final isProofed = await identityProof();
      if (isProofed) {
        emit(const ProofedOfIdentity());
      }
    } catch (error) {
      showErrorAlert(error.toString());
    }
  }

  void _onEnterFirstLocalPassword(
    EnterFirstLocalPassword event,
    Emitter<LocalPasswordSettingState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _firstPassword = event.password;
    emit(const GotFirstLocalPassword());
  }

  void _onEnterSecondLocalPassword(
    EnterSecondLocalPassword event,
    Emitter<LocalPasswordSettingState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (event.password == _firstPassword) {
        var hash = sha256.convert(utf8.encode(_firstPassword!)).toString();
        await _localAuthenticationRepository.savePassword(hash: hash);
        emit(const SuccessfulPasswordChange());
      } else {
        _firstPassword = null;
        emit(const InvalidConfirmedNewLocalPassword());
      }
    } catch (error) {
      emit(
          const ErrorNewLocalPasswordState('Ошибка создания цифрового пароля'));
    }
  }

  void _onDeleteLocalPassword(DeleteLocalPassword event,
      Emitter<LocalPasswordSettingState> emit) async {
    try {
      if (await identityProof()) {
        _localAuthenticationRepository.deleteLocalPassword();
        emit(const DeletedLocalPassword());
        showSuccessAlert('Вход в приложение по код-паролю выключен.');
      }
    } catch (error) {
      emit(ErrorNewLocalPasswordState(error.toString()));
    }
  }
}
