part of 'local_password_settings_bloc.dart';

abstract class NewLocalPasswordEvent extends Equatable {
  const NewLocalPasswordEvent();

  @override
  List<Object?> get props => [];
}

class LocalPasswordInitialSettingsEvent extends NewLocalPasswordEvent {
  const LocalPasswordInitialSettingsEvent();
}

class EnterFirstLocalPassword extends NewLocalPasswordEvent {
  const EnterFirstLocalPassword(this.firstPassword);

  final String firstPassword;

  @override
  List<Object?> get props => [firstPassword];
}

class EnterSecondLocalPassword extends NewLocalPasswordEvent {
  const EnterSecondLocalPassword(this.secondPassword);

  final String secondPassword;

  @override
  List<Object?> get props => [secondPassword];
}