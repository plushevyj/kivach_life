part of 'reset_password_by_email_bloc.dart';

abstract class ResetPasswordByEmailEvent extends Equatable {
  const ResetPasswordByEmailEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailEvent extends ResetPasswordByEmailEvent {
  const SendEmailEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
