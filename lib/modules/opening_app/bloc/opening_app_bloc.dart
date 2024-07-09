import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/http.dart';
import '../../../models/configuration_models/configuration_of_app/configuration_of_app.dart';
import '../controllers/configuration_of_app_controller.dart';
import '../repository/configuration_of_app_repository.dart';

part 'opening_app_event.dart';
part 'opening_app_state.dart';

class OpeningAppBloc extends Bloc<OpeningAppEvent, OpeningAppState> {
  final _configurationOfAppRepository = const ConfigurationOfAppRepository();
  var _showToast = true;

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

      GetIt.I.registerSingleton<Dio>(
          DioClient(baseUrl: configuration.BASE_URL).dio);
      Get.put(ConfigurationOfAppController(), permanent: true)
          .configuration
          .value = configuration;
      emit(SuccessConfigurationOfApp(configurationOfApp: configuration));
    } catch (error) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (_showToast) {
        Fluttertoast.showToast(
          msg:
              'Ошибка соединения с сервером или отсутствует подключение к интернету.',
          backgroundColor: Colors.grey,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          timeInSecForIosWeb: 5,
        );
      }
      _showToast = false;
      emit(const OpeningAppInitialState());
      add(const GetConfigurationOfApp());
    }
  }
}
