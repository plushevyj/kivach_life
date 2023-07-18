part of 'biometric_settings_bloc.dart';

abstract class BiometricSettingsEvent extends Equatable {
  const BiometricSettingsEvent();

  @override
  List<Object?> get props => [];
}

class CheckUser extends BiometricSettingsEvent {
  const CheckUser();
}