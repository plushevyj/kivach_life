part of 'reset_password_by_email_bloc.dart';

abstract class ResetPasswordByEmailState extends Equatable {
  const ResetPasswordByEmailState();

  @override
  List<Object> get props => [];
}

class ResetPasswordByEmailInitialState extends ResetPasswordByEmailState {
  const ResetPasswordByEmailInitialState();
}

class LoadingResetPasswordByEmailState extends ResetPasswordByEmailState {
  const LoadingResetPasswordByEmailState();
}

class SentEmailState extends ResetPasswordByEmailState {
  const SentEmailState();
}

class ErrorResetPasswordByEmailState extends ResetPasswordByEmailState {
  const ErrorResetPasswordByEmailState({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
