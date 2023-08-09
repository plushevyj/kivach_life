import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../../modules/local_password_settings/bloc/local_password_settings_bloc.dart';

class NewLocalPasswordController extends GetxController {
  late final TextEditingController firstPassword;
  late final TextEditingController secondPassword;

  final enableDialButtonsOfPassword = true.obs;
  final enableDialButtonsOfConfirmedPassword = true.obs;

  final reverse = true.obs;

  @override
  void onInit() {
    super.onInit();
    firstPassword = TextEditingController();
    secondPassword = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstPassword.addListener(
        () {
          enableDialButtonsOfPassword(
              firstPassword.text.length < maxLengthLocalPassword);
          if (firstPassword.text.length == maxLengthLocalPassword) {
            Get.context!
                .read<LocalPasswordSettingBloc>()
                .add(EnterFirstLocalPassword(firstPassword.text));
          }
        },
      );
      secondPassword.addListener(
        () {
          enableDialButtonsOfConfirmedPassword(
              secondPassword.text.length < maxLengthLocalPassword);
          if (secondPassword.text.length == maxLengthLocalPassword) {
            Get.context!
                .read<LocalPasswordSettingBloc>()
                .add(EnterSecondLocalPassword(secondPassword.text));
          }
        },
      );
    });
  }

  @override
  void onClose() {
    Get.context!
        .read<LocalPasswordSettingBloc>()
        .add(const LocalPasswordSettingsInitialEvent());
    firstPassword.dispose();
    secondPassword.dispose();
    super.onClose();
  }
}
