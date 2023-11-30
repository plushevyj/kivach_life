import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/modules/account/controllers/account_controller.dart';
import '/modules/account/controllers/avatar_controller.dart';
import '../../home_page_controller.dart';

class AppBarForLargeScreen extends StatelessWidget {
  const AppBarForLargeScreen({
    super.key,
    required this.homePageController,
    this.width,
  });

  final HomePageController homePageController;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final avatarController = Get.put(AvatarController());
    final profile = Get.find<AccountController>().profile.value;
    return Container(
      height: kToolbarHeight,
      width: width,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Obx(
                  () => IconButton(
                    onPressed: homePageController.canGoBack.value
                        ? () => homePageController.webViewController?.goBack()
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
                if (profile != null)
                  MenuAnchor(
                    style: MenuStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      surfaceTintColor:
                          MaterialStateProperty.all(Colors.transparent),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(1)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    menuChildren: [
                      if (profile.currentDoctor != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          color: Colors.white,
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Лечащий врач:\n',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: profile.currentDoctor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                    builder: (context, controller, widget) {
                      return GestureDetector(
                        onTap: () {
                          controller.isOpen
                              ? controller.close()
                              : controller.open();
                        },
                        child: Row(
                          children: [
                            Obx(
                              () => Skeletonizer(
                                enabled: avatarController.avatarLoading.value,
                                effect: ShimmerEffect(
                                    baseColor: Colors.grey.shade300),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: const Color(0xFFD7D7D7),
                                  foregroundImage:
                                      avatarController.image?.image,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                profile.fullName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
