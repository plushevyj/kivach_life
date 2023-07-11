part of 'local_authentication_bloc.dart';

abstract class LocalAuthenticationState extends Equatable {
  const LocalAuthenticationState();

  @override
  List<Object> get props => [];
}

class LocallyNotAuthenticated extends LocalAuthenticationState {
  const LocallyNotAuthenticated();
}

class GotSettings extends LocalAuthenticationState {
  const GotSettings({required this.settings});

  final LocalAuthenticationSettings settings;

  @override
  List<Object> get props => [settings];
}

class LocallyAuthenticated extends LocalAuthenticationState {
  const LocallyAuthenticated();
}

class LoadingLocalAuthentication extends LocalAuthenticationState {
  const LoadingLocalAuthentication();
}
