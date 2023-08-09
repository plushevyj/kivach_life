part of 'first_opening_of_app_bloc.dart';

abstract class FirstOpeningOfAppEvent extends Equatable {
  const FirstOpeningOfAppEvent();

  @override
  List<Object?> get props => [];
}

class CheckFirstOpeningOfApp extends FirstOpeningOfAppEvent {
  const CheckFirstOpeningOfApp();
}

class SaveFirstOpeningSetting extends FirstOpeningOfAppEvent {
  const SaveFirstOpeningSetting();
}