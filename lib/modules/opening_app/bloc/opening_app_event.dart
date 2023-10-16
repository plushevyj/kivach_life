part of 'opening_app_bloc.dart';

abstract class OpeningAppEvent extends Equatable {
  const OpeningAppEvent();

  @override
  List<Object?> get props => [];
}

class OpeningAppInitialEvent extends OpeningAppEvent {
  const OpeningAppInitialEvent();
}

class GetConfigurationOfApp extends OpeningAppEvent {
  const GetConfigurationOfApp();
}
