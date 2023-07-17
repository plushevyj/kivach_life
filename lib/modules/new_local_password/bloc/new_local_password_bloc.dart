import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_local_password_event.dart';
part 'new_local_password_state.dart';

class NewLocalPasswordBloc
    extends Bloc<NewLocalPasswordEvent, NewLocalPasswordState> {
  NewLocalPasswordBloc() : super(const NewLocalPasswordInitialState()) {
    on<NewLocalPasswordInitialEvent>(_onNewLocalPasswordEventInitial);
    on<EnterNewLocalPassword>(_onEnterNewLocalPassword);
    on<ConfirmLocalPassword>(_onGotConfirmedNewLocalPassword);
  }

  String? _passwordSaver;

  void _onNewLocalPasswordEventInitial(
    NewLocalPasswordInitialEvent event,
    Emitter<NewLocalPasswordState> emit,
  ) {
    _passwordSaver = null;
    emit(const NewLocalPasswordInitialState());
  }

  void _onEnterNewLocalPassword(
    EnterNewLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 500));
    _passwordSaver = event.password;
    emit(const GotNewLocalPassword());
  }

  void _onGotConfirmedNewLocalPassword(
    ConfirmLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 500));
      if (event.confirmedPassword == _passwordSaver) {
        print('${event.confirmedPassword} $_passwordSaver');
        emit(const SuccessfulPasswordChange());
      } else {
        emit(const InvalidConfirmedNewLocalPassword());
      }
    } catch (error) {
      print(error);
      showError('Ошибка обновления локального пароля');
      emit(const ErrorLocalPasswordState('Ошибка обновления локального пароля'));
    }
  }
}
