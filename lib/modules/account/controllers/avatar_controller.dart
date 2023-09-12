import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'account_controller.dart';

class AvatarController extends GetxController {
  final avatarLoading = false.obs;
  Image? image;

  @override
  void onInit() {
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
}
