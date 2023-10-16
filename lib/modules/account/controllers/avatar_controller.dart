import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../opening_app/controllers/configuration_of_app_controller.dart';
import 'account_controller.dart';

class AvatarController extends GetxController {
  final avatarLoading = false.obs;
  Image? image;

  @override
  void onInit() {
    final avatar = Get.find<AccountController>().profile.value?.avatar?.file;
    if (avatar != null) {
      avatarLoading(true);
      image = Image.network(
          '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}$avatar');
      image?.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((_, __) {
        avatarLoading(false);
      }));
    }
    super.onInit();
  }
}
