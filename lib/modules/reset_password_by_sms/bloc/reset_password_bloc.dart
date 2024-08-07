import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../logs/repository/logs_repository.dart';
import '/modules/authentication/repository/token_repository.dart';
import '../repository/reset_password_by_sms_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordInitial()) {
    on<ResetPasswordEventInitial>(_onResetPasswordEventInitial);
    on<SendNumber>(_onSendNumber);
    on<SendCode>(_onSendCode);
    on<GetReadyToSendData>(_onGetReadyToSendData);
  }

  final _resetPasswordRepository = ResetPasswordBySmsRepository();
  final _tokenRepository = const TokenRepository();
  String? _phone;

  void _onResetPasswordEventInitial(
    ResetPasswordEventInitial event,
    Emitter<ResetPasswordState> emit,
  ) {
    _phone = null;
    emit(const ResetPasswordInitial());
  }

  void _onSendNumber(
    SendNumber event,
    Emitter<ResetPasswordState> emit,
  ) async {
    try {
      int? remainingTime;
      if (event.phone != null) {
        _phone = event.phone;
      }
      if (_phone != null) {
        remainingTime =
            await _resetPasswordRepository.checkNumber(phone: _phone!);
      } else {
        throw 'Неизвестный номер телефона';
      }
      emit(SuccessNumber(remainingTime: remainingTime));
      emit(const ReadyToSendData());
    } catch (error) {
      emit(ErrorResetPasswordState(error.toString()));
    }
  }

  void _onGetReadyToSendData(
    GetReadyToSendData event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(const ReadyToSendData());
  }

  void _onSendCode(
    SendCode event,
    Emitter<ResetPasswordState> emit,
  ) async {
    try {
      final token = await _resetPasswordRepository.sendCode(
        phone: _phone ?? '',
        code: event.code,
      );

      const LogsRepository().sendLogs(json.encode({
        'event': 'Login by using phone',
        'accessToken': token.token,
        'refreshToken': token.refresh_token,
        'place': 'lib/modules/reset_password_by_sms/bloc/reset_password_bloc.dart:72',
      }));

      await _tokenRepository.saveTokens(token: token);
      emit(const SuccessCode());
    } catch (error) {
      emit(ErrorResetPasswordState(error.toString()));
    }
  }
}
