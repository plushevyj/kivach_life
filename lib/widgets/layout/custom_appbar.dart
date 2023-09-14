import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../modules/account/controllers/account_controller.dart';
import '../../modules/account/controllers/avatar_controller.dart';

class CustomAppBar
    extends StatelessWidget /* implements PreferredSizeWidget */ {
  const CustomAppBar({Key? key, required this.webViewController})
      : super(key: key);

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    final avatarController = Get.put(AvatarController());
    return Container(
      width: Get.width - 100,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => webViewController.goBack(),
                icon: Icon(
                  Platform.isIOS
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back_outlined,
                ),
              ),
              Obx(
                () => Skeletonizer(
                  enabled: avatarController.avatarLoading.value,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFD7D7D7),
                    foregroundImage: avatarController.image?.image,
                    child: const Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (Get.put(AccountController()).profile.value != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      Get.put(AccountController())
                          .profile
                          .value!
                          .patient
                          .firstname,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 55),
            child: IconButton(
                onPressed: () => Get.toNamed('/settings'),
                icon: const Icon(Icons.settings, size: 30)),
          ),
        ],
      ),
    );
  }

  // ///width doesnt matter
  // @override
  // Size get preferredSize => Size(Get.width - 100, kToolbarHeight);
}
