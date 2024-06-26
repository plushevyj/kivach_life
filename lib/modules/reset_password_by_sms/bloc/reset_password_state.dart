part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class SuccessNumber extends ResetPasswordInitial {
  const SuccessNumber({this.remainingTime});

  final int? remainingTime;

  @override
  List<Object?> get props => [remainingTime];
}

class ReadyToSendData extends ResetPasswordState {
  const ReadyToSendData();
}

class SuccessCode extends ResetPasswordInitial {
  const SuccessCode();
}

class ErrorResetPasswordState extends ResetPasswordState {
  const ErrorResetPasswordState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
