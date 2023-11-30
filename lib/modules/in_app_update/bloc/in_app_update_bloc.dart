import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../opening_app/controllers/configuration_of_app_controller.dart';
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
      final currentVersion = (await PackageInfo.fromPlatform()).version;
      if (GetPlatform.isIOS) {
        final response = await Dio().get(
            Get.find<ConfigurationOfAppController>()
                .configuration
                .value!
                .ITUNES_URL_FOR_REQUEST);
        final versionFromAppStore =
            jsonDecode(response.data)['results'].first['version'];
        if (versionFromAppStore != currentVersion) {
          InAppUpdateUI().showInAppUpdateIOSModal(Get.context!);
        }
      } else if (GetPlatform.isAndroid) {
        await InAppUpdate.checkForUpdate().then((info) async {
          if (info.updateAvailability == UpdateAvailability.updateAvailable) {
            await InAppUpdate.performImmediateUpdate();
          }
        });
      }
    } catch (_) {
      // rethrow;
    }
  }
}
