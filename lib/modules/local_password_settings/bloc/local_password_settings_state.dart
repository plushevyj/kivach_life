part of 'local_password_settings_bloc.dart';

abstract class LocalPasswordSettingState extends Equatable {
  const LocalPasswordSettingState();

  @override
  List<Object?> get props => [];
}

class LocalPasswordSettingsInitialState extends LocalPasswordSettingState {
  const LocalPasswordSettingsInitialState();
}

class ProofedOfIdentity extends LocalPasswordSettingState {
  const ProofedOfIdentity();
}

class NotProofedOfIdentity extends LocalPasswordSettingState {
  const NotProofedOfIdentity();
}

class GotFirstLocalPassword extends LocalPasswordSettingState {
  const GotFirstLocalPassword();
}

class SuccessfulPasswordChange extends LocalPasswordSettingState {
  const SuccessfulPasswordChange();
}

class InvalidConfirmedNewLocalPassword extends LocalPasswordSettingState {
  const InvalidConfirmedNewLocalPassword();
}

class DeletedLocalPassword extends LocalPasswordSettingState {
  const DeletedLocalPassword();
}

class ErrorNewLocalPasswordState extends LocalPasswordSettingState {
  const ErrorNewLocalPasswordState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
