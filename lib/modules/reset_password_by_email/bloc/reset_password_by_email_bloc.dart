import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/reset_password_by_email_repository.dart';

part 'reset_password_by_email_event.dart';
part 'reset_password_by_email_state.dart';

class ResetPasswordByEmailBloc
    extends Bloc<ResetPasswordByEmailEvent, ResetPasswordByEmailState> {
  ResetPasswordByEmailBloc() : super(const ResetPasswordByEmailInitialState()) {
    on<SendEmailEvent>(_onSendEmailEvent);
  }

  final _resetPasswordByEmailRepository = ResetPasswordByEmailRepository();

  void _onSendEmailEvent(
    SendEmailEvent event,
    Emitter<ResetPasswordByEmailState> emit,
  ) async {
    emit(const LoadingResetPasswordByEmailState());
    try {
      await _resetPasswordByEmailRepository.sendEmail(email: event.email);
    } catch (error) {
      emit(ErrorResetPasswordByEmailState(message: error.toString()));
    }
  }
}
