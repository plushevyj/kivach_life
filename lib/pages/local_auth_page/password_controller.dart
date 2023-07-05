import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class PasswordController extends GetxController {
  late final TextEditingController password;
  final enableDialButton = true.obs;

  @override
  void onInit() {
    password = TextEditingController()
      ..addListener(() {
        enableDialButton(password.text.length < 4);
        if (password.text.length == 4) {
          Get.context!
              .read<LocalAuthenticationBloc>()
              .add(LogInLocallyUsingDigitalPassword(password.text));
        }
      });
    super.onInit();
  }

  void enterNumberToPassword(int number) {
    if (password.text.length <= 4) password.text += number.toString();
  }

  void deleteNumberFromPassword() {
    password.text = password.text.substring(0, password.text.length - 1);
  }
}
