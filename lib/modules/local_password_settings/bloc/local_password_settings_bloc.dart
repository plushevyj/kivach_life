import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:doctor/modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import 'package:doctor/modules/identity_proof/ui/identity_proof_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '/models/local_password_model/local_password_model.dart';
import '/modules/local_authentication/repository/local_authentication_repository.dart';
import '/widgets/alerts.dart';

part 'local_password_settings_event.dart';
part 'local_password_settings_state.dart';

class LocalPasswordSettingBloc
    extends Bloc<LocalPasswordSettingEvent, LocalPasswordSettingState> {
  LocalPasswordSettingBloc()
      : super(const LocalPasswordSettingsInitialState()) {
    on<LocalPasswordSettingsInitialEvent>(_onNewLocalPasswordEventInitial);
    // on<ProofOfIdentity>(_onProofOfIdentity);
    on<EnterFirstLocalPassword>(_onEnterFirstLocalPassword);
    on<EnterSecondLocalPassword>(_onEnterSecondLocalPassword);
    on<DeleteLocalPassword>(_onDeleteLocalPassword);
  }

  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  String? _firstPassword;

  void _onNewLocalPasswordEventInitial(
    LocalPasswordSettingsInitialEvent event,
    Emitter<LocalPasswordSettingState> emit,
  ) async {
    _firstPassword = null;
    final authenticationSetting =
        await _localAuthenticationRepository.checkLocalAuthenticationSettings();
    if (authenticationSetting.$1) {
      if (await identityProof()) {
        emit(const ProofedOfIdentity());
      } else {
        emit(const NotProofedOfIdentity());
      }
    } else {
      emit(const ProofedOfIdentity());
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
        final localPasswordLocalPassword = LocalPassword(hash: hash);
        _localAuthenticationRepository.savePassword(localPasswordLocalPassword);
        emit(const SuccessfulPasswordChange());
      } else {
        _firstPassword = null;
        emit(const InvalidConfirmedNewLocalPassword());
      }
    } catch (error) {
      emit(const ErrorNewLocalPasswordState(
          'Ошибка добавления локального пароля'));
    }
  }

  void _onDeleteLocalPassword(DeleteLocalPassword event,
      Emitter<LocalPasswordSettingState> emit) async {
    try {
      if (await identityProof()) {
        _localAuthenticationRepository.deleteLocalPassword();
        emit(const DeletedLocalPassword());
      }
    } catch (_) {}
  }
}
