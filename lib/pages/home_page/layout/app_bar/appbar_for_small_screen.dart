import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../modules/account/controllers/account_controller.dart';
import '../../../../modules/account/controllers/avatar_controller.dart';
import '../../home_page_controller.dart';

class AppBarForSmallScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarForSmallScreen({
    super.key,
    required this.homePageController,
    required this.webViewController,
  });

  final HomePageController homePageController;
  final InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    final avatarController = Get.put(AvatarController());
    return AppBar(
      backgroundColor: const Color(0xFFF3F5F6),
      centerTitle: false,
      leadingWidth: 96,
      leading: Row(
        children: [
          Obx(
            () => IconButton(
              onPressed: homePageController.canGoBack.value
                  ? () => webViewController.goBack()
                  : null,
              icon: Icon(
                GetPlatform.isIOS
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back_outlined,
                color: homePageController.canGoBack.value
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          Obx(
            () => Skeletonizer(
              enabled: avatarController.avatarLoading.value,
              effect: ShimmerEffect(baseColor: Colors.grey.shade300),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFD7D7D7),
                foregroundImage: avatarController.image?.image,
                child: avatarController.image == null
                    ? const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (Get.find<AccountController>().profile.value != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  Get.find<AccountController>().profile.value!.username,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Get.toNamed('/settings'),
          icon: const Icon(Icons.settings, size: 30),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
