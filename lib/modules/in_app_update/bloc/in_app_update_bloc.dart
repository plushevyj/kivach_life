import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'in_app_update_event.dart';
part 'in_app_update_state.dart';

class InAppUpdateBloc extends Bloc<InAppUpdateEvent, InAppUpdateState> {
  InAppUpdateBloc() : super(const InAppUpdateInitial()) {
    on<CheckVersionApp>(_checkVersionApp);
  }

  void _checkVersionApp(
    CheckVersionApp event,
    Emitter<InAppUpdateState> emit,
  ) {
    if (Platform.isIOS) {
      final response =
          Dio().get('itunes.apple.com/lookup?bundleId=ru.kivach.doctor');
      print(response);
    }
  }
}
