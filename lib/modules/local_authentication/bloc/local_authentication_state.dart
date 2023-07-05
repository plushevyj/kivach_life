part of 'local_authentication_bloc.dart';

abstract class LocalAuthenticationState extends Equatable {
  const LocalAuthenticationState();

  @override
  List<Object> get props => [];
}

class LocallyNotAuthenticated extends LocalAuthenticationState {
  const LocallyNotAuthenticated();
}

class LocallyAuthenticated extends LocalAuthenticationState {
  const LocallyAuthenticated();
}

class LoadingLocalAuthentication extends LocalAuthenticationState {
  const LoadingLocalAuthentication();
}
