part of 'in_app_update_bloc.dart';

abstract class InAppUpdateEvent extends Equatable {
  const InAppUpdateEvent();

  @override
  List<Object?> get props => [];
}

class CheckVersionApp extends InAppUpdateEvent {
  const CheckVersionApp();
}
