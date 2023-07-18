part of 'new_local_password_bloc.dart';

abstract class NewLocalPasswordState extends Equatable {
  const NewLocalPasswordState();

  @override
  List<Object?> get props => [];
}

class NewLocalPasswordInitialState extends NewLocalPasswordState {
  const NewLocalPasswordInitialState();
}

class GotFirstLocalPassword extends NewLocalPasswordState {
  const GotFirstLocalPassword();
}

class GotSecondLocalPassword extends NewLocalPasswordState {
  const GotSecondLocalPassword();
}

class SuccessfulPasswordChange extends NewLocalPasswordState {
  const SuccessfulPasswordChange();
}

class InvalidConfirmedNewLocalPassword extends NewLocalPasswordState {
  const InvalidConfirmedNewLocalPassword();
}

class ErrorLocalPasswordState extends NewLocalPasswordState {
  const ErrorLocalPasswordState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
