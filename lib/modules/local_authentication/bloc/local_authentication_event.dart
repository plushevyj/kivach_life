part of 'local_authentication_bloc.dart';

abstract class LocalAuthenticationEvent extends Equatable {
  const LocalAuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class LogOutLocally extends LocalAuthenticationEvent {
  const LogOutLocally();
}

class LogInLocallyUsingBiometrics extends LocalAuthenticationEvent {
  const LogInLocallyUsingBiometrics();
}

class LogInLocallyUsingDigitalPassword extends LocalAuthenticationEvent {
  final String password;
  const LogInLocallyUsingDigitalPassword(this.password);

  @override
  List<Object?> get props => [password];
}
