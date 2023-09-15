import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../modules/account/controllers/account_controller.dart';
import '../../modules/account/controllers/avatar_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.webViewController})
      : super(key: key);

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    final avatarController = Get.put(AvatarController());
    return Container(
      height: kToolbarHeight,
      width: Get.width - 60,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed('/settings'),
            icon: const Icon(Icons.settings, size: 30),
          ),
        ],
      ),
    );
  }
}