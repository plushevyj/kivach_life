part of 'local_password_settings_bloc.dart';

abstract class NewLocalPasswordState extends Equatable {
  const NewLocalPasswordState();

  @override
  List<Object?> get props => [];
}

class LocalPasswordInitialSettingsState extends NewLocalPasswordState {
  const LocalPasswordInitialSettingsState();
}

class GotFirstLocalPassword extends NewLocalPasswordState {
  const GotFirstLocalPassword();
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
