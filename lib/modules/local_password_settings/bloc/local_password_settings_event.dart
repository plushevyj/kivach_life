part of 'local_password_settings_bloc.dart';

abstract class LocalPasswordSettingEvent extends Equatable {
  const LocalPasswordSettingEvent();

  @override
  List<Object?> get props => [];
}

class LocalPasswordSettingsInitialEvent extends LocalPasswordSettingEvent {
  const LocalPasswordSettingsInitialEvent();

  @override
  List<Object?> get props => [];
}

class CreatePassword extends LocalPasswordSettingEvent {
  const CreatePassword();
}

class EnterFirstLocalPassword extends LocalPasswordSettingEvent {
  const EnterFirstLocalPassword(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class DeleteLocalPassword extends LocalPasswordSettingEvent {
  const DeleteLocalPassword();
}

class EnterSecondLocalPassword extends LocalPasswordSettingEvent {
  const EnterSecondLocalPassword(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}