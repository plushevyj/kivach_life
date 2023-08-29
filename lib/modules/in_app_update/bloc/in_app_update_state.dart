part of 'in_app_update_bloc.dart';

abstract class InAppUpdateState extends Equatable {
  const InAppUpdateState();

  @override
  List<Object> get props => [];
}

class InAppUpdateInitial extends InAppUpdateState {
  const InAppUpdateInitial();
}

class CallUpdateAppModal extends InAppUpdateState {
  const CallUpdateAppModal();
}