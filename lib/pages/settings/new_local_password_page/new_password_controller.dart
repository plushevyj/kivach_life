import 'package:doctor/modules/new_local_password/bloc/new_local_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../local_auth_page/local_password_controller.dart';

class NewLocalPasswordController extends GetxController {
  late final TextEditingController password;
  late final TextEditingController confirmedPassword;

  final enableDialButtonsOfPassword = true.obs;
  final enableDialButtonsOfConfirmedPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    password = TextEditingController();
    confirmedPassword = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.context!
          .read<NewLocalPasswordBloc>()
          .add(const NewLocalPasswordInitialEvent());
      password.addListener(
        () {
          enableDialButtonsOfPassword(password.text.length <
              LocalPasswordController.maxLengthLocalPassword);
          if (password.text.length ==
              LocalPasswordController.maxLengthLocalPassword) {
            Get.context!
                .read<NewLocalPasswordBloc>()
                .add(EnterNewLocalPassword(password.text));
          }
        },
      );
      confirmedPassword.addListener(
        () {
          enableDialButtonsOfConfirmedPassword(confirmedPassword.text.length <
              LocalPasswordController.maxLengthLocalPassword);
          if (confirmedPassword.text.length ==
              LocalPasswordController.maxLengthLocalPassword) {
            Get.context!
                .read<NewLocalPasswordBloc>()
                .add(ConfirmLocalPassword(confirmedPassword.text));
          }
        },
      );
    });
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }
}
