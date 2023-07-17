part of 'new_local_password_bloc.dart';

abstract class NewLocalPasswordEvent extends Equatable {
  const NewLocalPasswordEvent();

  @override
  List<Object?> get props => [];
}

class NewLocalPasswordInitialEvent extends NewLocalPasswordEvent {
  const NewLocalPasswordInitialEvent();
}

class EnterNewLocalPassword extends NewLocalPasswordEvent {
  const EnterNewLocalPassword(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmLocalPassword extends NewLocalPasswordEvent {
  const ConfirmLocalPassword(this.confirmedPassword);

  final String confirmedPassword;

  @override
  List<Object?> get props => [confirmedPassword];
}