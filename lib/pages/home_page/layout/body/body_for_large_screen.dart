import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../home_page_controller.dart';
import '../app_bar/app_bar_for_large_screen.dart';

class BodyForLargeScreen extends StatelessWidget {
  const BodyForLargeScreen({
    super.key,
    required this.homePageController,
    required this.webViewController,
  });

  final HomePageController homePageController;
  final InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Obx(
            () => Container(
              padding: EdgeInsets.only(
                  top: homePageController.isNarrowAppBar.value
                      ? 0
                      : kToolbarHeight),
              child: InAppWebView(
                  // controller: webViewController,
                  ),
            ),
          ),
          Obx(
            () => AppBarForLargeScreen(
              homePageController: homePageController,
              width: homePageController.isNarrowAppBar.value
                  ? Get.width - 60
                  : Get.width - 5,
            ),
          ),
        ],
      ),
    );
  }
}
