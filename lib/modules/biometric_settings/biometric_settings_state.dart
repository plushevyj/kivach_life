part of 'biometric_settings_bloc.dart';

abstract class BiometricSettingsState extends Equatable {
  const BiometricSettingsState();

  @override
  List<Object> get props => [];
}

class BiometricSettingsInitial extends BiometricSettingsState {
  const BiometricSettingsInitial();
}

class InvalidUserBiometricData extends BiometricSettingsState {
  const InvalidUserBiometricData();
}

class ValidUserBiometricData extends BiometricSettingsState {
  const ValidUserBiometricData();
}

class ErrorBiometricSettings extends BiometricSettingsState {
  const ErrorBiometricSettings(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}