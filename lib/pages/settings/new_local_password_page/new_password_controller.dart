import 'package:doctor/modules/new_local_password/bloc/new_local_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../local_auth_page/local_password_controller.dart';

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
      Get.context!
          .read<NewLocalPasswordBloc>()
          .add(const NewLocalPasswordInitialEvent());
      firstPassword.addListener(
        () {
          print(firstPassword.text);
          enableDialButtonsOfPassword(firstPassword.text.length <
              maxLengthLocalPassword);
          if (firstPassword.text.length ==
              maxLengthLocalPassword) {
            print('kek');
            Get.context!
                .read<NewLocalPasswordBloc>()
                .add(EnterFirstLocalPassword(firstPassword.text));
          }
        },
      );
      secondPassword.addListener(
        () {
          print(secondPassword.text);
          enableDialButtonsOfConfirmedPassword(secondPassword.text.length <
              maxLengthLocalPassword);
          if (secondPassword.text.length ==
              maxLengthLocalPassword) {
            Get.context!
                .read<NewLocalPasswordBloc>()
                .add(EnterSecondLocalPassword(secondPassword.text));
          }
        },
      );
    });
  }

  @override
  void dispose() {
    firstPassword.dispose();
    secondPassword.dispose();
    super.dispose();
  }
}
