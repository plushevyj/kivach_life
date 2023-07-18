import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class LocalPasswordController extends GetxController {
  late final TextEditingController password;

  final enableDialButtons = true.obs;

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
