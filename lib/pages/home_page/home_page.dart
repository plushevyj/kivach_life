import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../core/themes/light_theme.dart';
import 'home_page_controller.dart';
import 'layout/app_bar/app_bar_for_large_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    return PopScope(
      onPopInvoked: (didPop) async {
        homePageController.webViewController?.goBack();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      top: homePageController.isNarrowAppBar.value
                          ? 0
                          : kToolbarHeight),
                  child: InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useOnDownloadStart: true,
                        supportZoom: false,
                        preferredContentMode: UserPreferredContentMode.MOBILE,
                        useShouldOverrideUrlLoading: true,
                        userAgent: FkUserAgent.userAgent ?? 'Unknown',
                      ),
                      android: AndroidInAppWebViewOptions(
                        builtInZoomControls: false,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                        sharedCookiesEnabled: true,
                      ),
                    ),
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT,
                      );
                    },
                    onWebViewCreated: (controller) {
                      homePageController
                        ..webViewController = controller
                        ..loadFirstBaseSiteRoute();
                    },
                    pullToRefreshController:
                        homePageController.pullToRefreshController,
                    onLoadStart: homePageController.onLoadStart,
                    onLoadStop: homePageController.onLoadStop,
                    shouldOverrideUrlLoading:
                        homePageController.shouldOverrideUrlLoading,
                    onProgressChanged: homePageController.onProgressChanged,
                    onDownloadStartRequest:
                        homePageController.onDownloadStartRequest,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: KivachColors.lightGreen,
                    value: homePageController.progress.value,
                    minHeight: 3,
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
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: homePageController.navBarIndexNotifier,
          builder: (_, currentIndex, __) {
            return BottomNavigationBar(
              backgroundColor: null,
              currentIndex: currentIndex,
              onTap: (index) {
                homePageController.navBarIndexNotifier.value = index;
                homePageController.loadBaseSiteRoute(
                    route: homePageController.navbar![index].route);
              },
              enableFeedback: false,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 24),
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              selectedItemColor: KivachColors.green,
              unselectedItemColor: const Color(0xFFAEB2BA),
              type: BottomNavigationBarType.fixed,
              items: homePageController.navbar!
                  .map(
                    (element) => BottomNavigationBarItem(
                      icon: Icon(
                        IconData(
                          int.parse(element.icon),
                          fontFamily: 'MaterialIcons',
                        ),
                      ),
                      label: element.label,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
