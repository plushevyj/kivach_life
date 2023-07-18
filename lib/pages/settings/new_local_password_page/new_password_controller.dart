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

  final onFirstPage = true.obs;

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
                .read<LocalPasswordSettingsBloc>()
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
                .read<LocalPasswordSettingsBloc>()
                .add(EnterSecondLocalPassword(secondPassword.text));
          }
        },
      );
    });
  }

  @override
  void onClose() {
    Get.context!
        .read<LocalPasswordSettingsBloc>()
        .add(const LocalPasswordInitialSettingsEvent());
    firstPassword.dispose();
    secondPassword.dispose();
    super.onClose();
  }
}
