import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class PasswordController extends GetxController {
  late final TextEditingController password;

  final enableDialButtons = true.obs;

  static const maxLengthLocalPassword = 4;

  @override
  void onInit() {
    super.onInit();
    password = TextEditingController()
      ..addListener(() {
        enableDialButtons(password.text.length < maxLengthLocalPassword);
        if (password.text.length == maxLengthLocalPassword) {
          Get.context!
              .read<LocalAuthenticationBloc>()
              .add(LogInLocallyUsingDigitalPassword(password.text));
        }
      });
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }
}
