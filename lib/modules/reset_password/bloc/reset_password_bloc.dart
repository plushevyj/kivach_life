import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/modules/authentication/repository/token_repository.dart';
import '../repository/reset_password_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordInitial()) {
    on<ResetPasswordEventInitial>(_onResetPasswordEventInitial);
    on<SendNumber>(_onSendNumber);
    on<SendCode>(_onSendCode);
    on<GetReadyToSendCode>(_onGetReadyToSendCode);
  }

  final _resetPasswordRepository = ResetPasswordRepository();
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
      if (event.phone != null) {
        _phone = event.phone;
      }
      if (_phone != null) {
        await _resetPasswordRepository.checkNumber(phone: _phone!);
      } else {
        throw 'Неизвестный номер телефона';
      }
      emit(const SuccessNumber());
      emit(const ReadyToSendCode());
    } catch (error) {
      emit(ErrorResetPasswordState(error.toString()));
    }
  }

  void _onGetReadyToSendCode(
    GetReadyToSendCode event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(const ReadyToSendCode());
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
      await _tokenRepository.saveToken(token: token);
      emit(const SuccessCode());
    } catch (error) {
      emit(ErrorResetPasswordState(error.toString()));
    }
  }
}
