part of 'first_opening_of_app_bloc.dart';

abstract class FirstOpeningOfAppState extends Equatable {
  const FirstOpeningOfAppState();

  @override
  List<Object> get props => [];
}

class FirstOpeningOfApp extends FirstOpeningOfAppState {
  const FirstOpeningOfApp();
}

class NotFirstOpeningOfApp extends FirstOpeningOfAppState {
  const NotFirstOpeningOfApp();
}
