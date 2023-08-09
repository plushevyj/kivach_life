import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/first_opening_of_app_model/first_opening_of_app_model.dart';
import '/modules/first_opening_of_app/repository/first_opening_of_app_repository.dart';

part 'first_opening_of_app_event.dart';
part 'first_opening_of_app_state.dart';

class FirstOpeningOfAppBloc
    extends Bloc<FirstOpeningOfAppEvent, FirstOpeningOfAppState> {
  FirstOpeningOfAppBloc() : super(const NotFirstOpeningOfApp()) {
    const firstOpeningOfAppRepository = FirstOpeningOfAppRepository();

    on<CheckFirstOpeningOfApp>((event, emit) async {
      var check = false;
      try {
        check = await firstOpeningOfAppRepository.checkFirstOpening();
      } finally {
        if (check) {
          emit(const FirstOpeningOfApp());
        } else {
          emit(const NotFirstOpeningOfApp());
        }
      }
    });

    on<SaveFirstOpeningSetting>((event, emit) {
      try {
        firstOpeningOfAppRepository
            .saveFirstOpeningSetting(FirstOpeningOfAppModel(state: false));
        emit(const NotFirstOpeningOfApp());
      } catch (error) {
        print(error);
      }
    });
  }
}
