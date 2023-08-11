part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class Authenticated extends AuthenticationState {
  const Authenticated();
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class AuthenticationError extends AuthenticationState {
  final String error;

  const AuthenticationError(this.error);

  @override
  List<Object> get props => [error];
}
