part of 'local_authentication_bloc.dart';

abstract class LocalAuthenticationEvent extends Equatable {
  const LocalAuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class LocallyAuthStarted extends LocalAuthenticationEvent {
  const LocallyAuthStarted();
}

class CheckSettings extends LocalAuthenticationEvent{
  const CheckSettings();
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

class LocallyLogOut extends LocalAuthenticationEvent {
  const LocallyLogOut();
}
