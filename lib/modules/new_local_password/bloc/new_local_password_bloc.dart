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
    on<EnterFirstLocalPassword>(_onEnterNewLocalPassword);
    on<EnterSecondLocalPassword>(_onGotConfirmedNewLocalPassword);
  }

  String? _firstPassword;

  void _onNewLocalPasswordEventInitial(
    NewLocalPasswordInitialEvent event,
    Emitter<NewLocalPasswordState> emit,
  ) {
    _firstPassword = null;
    emit(const NewLocalPasswordInitialState());
  }

  void _onEnterNewLocalPassword(
    EnterFirstLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _firstPassword = event.password;
    emit(const GotFirstLocalPassword());
  }

  void _onGotConfirmedNewLocalPassword(
    EnterSecondLocalPassword event,
    Emitter<NewLocalPasswordState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (event.confirmedPassword == _firstPassword) {
        print('${event.confirmedPassword} $_firstPassword');
        emit(const SuccessfulPasswordChange());
      } else {
        emit(const InvalidConfirmedNewLocalPassword());
      }
    } catch (error) {
      print(error);
      showError('Ошибка добавления локального пароля');
      emit(const ErrorLocalPasswordState('Ошибка добавления локального пароля'));
    }
  }
}
