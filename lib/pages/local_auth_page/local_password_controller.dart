import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '../../modules/account/controller/account_controller.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';

class LocalPasswordPageController extends GetxController {
  late final TextEditingController password;

  final firstRenderer = true.obs;
  final enableDialButtons = true.obs;
  final avatarLoading = false.obs;
  Image? image;

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

    final avatar = Get.put(AccountController()).profile.value?.avatar?.file;
    if (avatar != null) {
      avatarLoading(true);
      image = Image.network('${dotenv.get('BASE_URL')}$avatar');
      image?.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((_, __) {
        avatarLoading(false);
      }));
    }

    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }
}
