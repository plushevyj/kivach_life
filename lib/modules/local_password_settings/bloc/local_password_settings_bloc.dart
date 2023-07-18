import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/local_password_model/local_password_model.dart';
import '../repository/local_authentication_repository_impl.dart';

part 'local_password_settings_event.dart';
part 'local_password_settings_state.dart';

class LocalPasswordSettingsBloc
    extends Bloc<NewLocalPasswordEvent, NewLocalPasswordState> {
  LocalPasswordSettingsBloc() : super(const LocalPasswordInitialSettingsState()) {
    on<LocalPasswordInitialSettingsEvent>(_onNewLocalPasswordEventInitial);
    on<EnterFirstLocalPassword>(_onEnterFirstLocalPassword);
    on<EnterSecondLocalPassword>(_onEnterSecondLocalPassword);
  }

  final _repository = const NewLocalPasswordRepositoryImpl();

  String? _firstPassword;

  void _onNewLocalPasswordEventInitial(
    LocalPasswordInitialSettingsEvent event,
    Emitter<NewLocalPasswordState> emit,
  ) {
    _firstPassword = null;
    emit(const LocalPasswordInitialSettingsState());
  }

  void _onEnterFirstLocalPassword(
    EnterFirstLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _firstPassword = event.firstPassword;
    emit(const GotFirstLocalPassword());
  }

  void _onEnterSecondLocalPassword(
    EnterSecondLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (event.secondPassword == _firstPassword) {
        var hash = sha256.convert(utf8.encode(_firstPassword!)).toString();
        print('hash = $hash');
        final localPasswordLocalPassword = LocalPassword(hash: hash);
        _repository.savePassword(localPasswordLocalPassword);
        emit(const SuccessfulPasswordChange());
      } else {
        emit(const InvalidConfirmedNewLocalPassword());
      }
    } catch (error) {
      emit(
          const ErrorLocalPasswordState('Ошибка добавления локального пароля'));
    }
  }
}
