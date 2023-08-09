part of 'biometric_settings_bloc.dart';

abstract class BiometricSettingsEvent extends Equatable {
  const BiometricSettingsEvent();

  @override
  List<Object?> get props => [];
}

class EnableBiometricsLogin extends BiometricSettingsEvent {
  const EnableBiometricsLogin(this.state);

  final bool state;

  @override
  List<Object?> get props => [state];
}