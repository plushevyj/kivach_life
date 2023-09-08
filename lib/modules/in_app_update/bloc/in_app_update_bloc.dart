import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../ui/in_app_update_ios_modal.dart';

part 'in_app_update_event.dart';
part 'in_app_update_state.dart';

class InAppUpdateBloc extends Bloc<InAppUpdateEvent, InAppUpdateState> {
  InAppUpdateBloc() : super(const InAppUpdateInitial()) {
    on<CheckVersionApp>(_checkVersionApp);
  }

  void _checkVersionApp(
    CheckVersionApp event,
    Emitter<InAppUpdateState> emit,
  ) async {
    try {
      if (Platform.isIOS) {
        final response = await Dio()
            .get('https://itunes.apple.com/lookup?bundleId=ru.kivach.doctor');
        final versionFromAppStore =
            jsonDecode(response.data)['results'].first['version'];
        final currentVersion = (await PackageInfo.fromPlatform()).version;
        if (versionFromAppStore != currentVersion) {
          InAppUpdateUI().showInAppUpdateIOSModal();
        }
      }
    } catch (_) {rethrow;}
  }
}
