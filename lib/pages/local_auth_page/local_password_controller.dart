import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/utils/constants.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class LocalPasswordPageController extends GetxController {
  late final TextEditingController password;

  final firstRenderer = true.obs;
  final enableDialButtons = true.obs;

  @override
  void onInit() {
    password = TextEditingController()
      ..addListener(() {
        enableDialButtons(password.text.length < maxLengthLocalPassword);
        if (password.text.length == maxLengthLocalPassword) {
          Get.context!
              .read<LocalAuthenticationBloc>()
              .add(LogInLocallyUsingDigitalPassword(password.text));
        }
      });
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }
}
