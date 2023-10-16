import 'package:doctor/models/configuration_models/configuration_of_app/configuration_of_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../controllers/configuration_of_app_controller.dart';
import '../repository/configuration_of_app_repository.dart';

part 'opening_app_event.dart';
part 'opening_app_state.dart';

class OpeningAppBloc extends Bloc<OpeningAppEvent, OpeningAppState> {
  final _configurationOfAppRepository = const ConfigurationOfAppRepository();

  OpeningAppBloc() : super(const OpeningAppInitialState()) {
    on<OpeningAppInitialEvent>(_onOpeningAppInitialEvent);
    on<GetConfigurationOfApp>(_onGetConfigurationOfApp);
  }

  void _onOpeningAppInitialEvent(
    OpeningAppInitialEvent event,
    Emitter<OpeningAppState> emit,
  ) {
    emit(const OpeningAppInitialState());
  }

  void _onGetConfigurationOfApp(
    GetConfigurationOfApp event,
    Emitter<OpeningAppState> emit,
  ) async {
    try {
      final configuration =
          await _configurationOfAppRepository.getConfigurationOfApp();
      Get.put(ConfigurationOfAppController(), permanent: true)
          .configuration
          .value = configuration;
      emit(const SuccessConfigurationOfApp());
    } catch (error) {
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(const OpeningAppInitialState());
      add(const GetConfigurationOfApp());
      print(error.toString());
      print(error.toString());
      print(error.toString());
      print(error.toString());
      print(error.toString());
      print(error.toString());
    }
  }
}
