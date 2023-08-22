part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticateByToken extends AuthenticationEvent {
  const AuthenticateByToken();
}

class LogIn extends AuthenticationEvent {
  final String username;
  final String password;

  const LogIn({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogOut extends AuthenticationEvent {
  const LogOut();
}
