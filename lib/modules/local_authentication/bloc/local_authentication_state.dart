part of 'local_authentication_bloc.dart';

abstract class LocalAuthenticationState extends Equatable {
  const LocalAuthenticationState();

  @override
  List<Object> get props => [];
}

class LocalAuthenticationInitialState extends LocalAuthenticationState {
  const LocalAuthenticationInitialState();
}

class LoadingLocalAuthentication extends LocalAuthenticationState {
  const LoadingLocalAuthentication(this.localAuthenticationSetting);

  final (bool, bool) localAuthenticationSetting;

  @override
  List<Object> get props => [localAuthenticationSetting];
}

class LocallyNotAuthenticated extends LocalAuthenticationState {
  const LocallyNotAuthenticated(this.localAuthenticationSetting);

  final (bool, bool) localAuthenticationSetting;

  @override
  List<Object> get props => [localAuthenticationSetting];
}

class LocallyAuthenticated extends LocalAuthenticationState {
  const LocallyAuthenticated();
}

class LocalAuthenticationError extends LocalAuthenticationState {
  const LocalAuthenticationError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
