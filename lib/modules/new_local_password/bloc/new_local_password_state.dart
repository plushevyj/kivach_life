part of 'new_local_password_bloc.dart';

abstract class NewLocalPasswordState extends Equatable {
  const NewLocalPasswordState();

  @override
  List<Object?> get props => [];
}

class NewLocalPasswordInitialState extends NewLocalPasswordState {
  const NewLocalPasswordInitialState();
}

class GotNewLocalPassword extends NewLocalPasswordState {
  const GotNewLocalPassword();
}

class GotConfirmedNewLocalPassword extends NewLocalPasswordState {
  const GotConfirmedNewLocalPassword();
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
