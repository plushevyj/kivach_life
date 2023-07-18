part of 'new_local_password_bloc.dart';

abstract class NewLocalPasswordEvent extends Equatable {
  const NewLocalPasswordEvent();

  @override
  List<Object?> get props => [];
}

class NewLocalPasswordInitialEvent extends NewLocalPasswordEvent {
  const NewLocalPasswordInitialEvent();
}

class EnterFirstLocalPassword extends NewLocalPasswordEvent {
  const EnterFirstLocalPassword(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class EnterSecondLocalPassword extends NewLocalPasswordEvent {
  const EnterSecondLocalPassword(this.confirmedPassword);

  final String confirmedPassword;

  @override
  List<Object?> get props => [confirmedPassword];
}