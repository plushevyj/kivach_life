part of 'opening_app_bloc.dart';

abstract class OpeningAppState extends Equatable {
  const OpeningAppState();

  @override
  List<Object> get props => [];
}

class OpeningAppInitialState  extends OpeningAppState {
  const OpeningAppInitialState();
}

class SuccessConfigurationOfApp extends OpeningAppState {
  const SuccessConfigurationOfApp({required this.configurationOfApp});

  final ConfigurationOfApp configurationOfApp;

  @override
  List<Object> get props => [configurationOfApp];
}

class ErrorConfigurationOfApp extends OpeningAppState {
  const ErrorConfigurationOfApp(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
