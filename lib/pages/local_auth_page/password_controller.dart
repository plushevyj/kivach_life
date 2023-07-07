import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class PasswordController extends GetxController {
  late final TextEditingController password;

  final enableDialButton = true.obs;
  final showBiometricButton = true.obs;
  final localPasswordLength = 0.obs;

  static const maxLengthLocalPassword = 4;

  @override
  void onInit() {
    password = TextEditingController()
      ..addListener(() {
        localPasswordLength(password.text.length);
        enableDialButton(password.text.length < maxLengthLocalPassword);
        if (password.text.length == maxLengthLocalPassword) {
          Get.context!
              .read<LocalAuthenticationBloc>()
              .add(LogInLocallyUsingDigitalPassword(password.text));
        }
        showBiometricButton(password.text.isEmpty);
      });
    super.onInit();
  }

  void enterNumberToPassword(int number) {
    if (password.text.length <= maxLengthLocalPassword) {
      password.text += number.toString();
    }
  }

  void deleteNumberFromPassword() {
    if (password.text.isNotEmpty) {
      password.text = password.text.substring(0, password.text.length - 1);
    }
  }
}
