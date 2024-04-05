import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/core/themes/light_theme.dart';
import 'home_page_controller.dart';
import 'layout/app_bar/app_bar_for_large_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    WidgetsBinding.instance.addPostFrameCallback((_) => FlutterNativeSplash.remove());
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        homePageController.webViewController?.goBack();
      },
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(top: homePageController.isNarrowAppBar.value ? 0 : kToolbarHeight),
                        child: InAppWebView(
                          initialSettings: InAppWebViewSettings(
                            useOnDownloadStart: true,
                            userAgent: homePageController.userAgent ?? 'Unknown',
                            preferredContentMode: UserPreferredContentMode.MOBILE,
                            supportZoom: false,
                            allowsInlineMediaPlayback: true,
                            sharedCookiesEnabled: true,
                            useShouldOverrideUrlLoading: true,
                          ),
                          onPermissionRequest: (controller, request) async {
                            return PermissionResponse(
                              resources: request.resources,
                              action: PermissionResponseAction.GRANT,
                            );
                          },
                          onWebViewCreated: (controller) {
                            homePageController
                              ..webViewController = controller
                              ..loadFirstBaseSiteRoute();
                          },
                          onReceivedError: (controller, resource, error) {
                            if ([-2, -1009].contains(error.type.toNativeValue()) ||
                                ['net::ERR_INTERNET_DISCONNECTED', 'The Internet connection appears to be offline.']
                                    .contains(error.description)) {
                              controller.loadData(data: '');
                              homePageController.internetConnected(false);
                            }
                          },
                          onReceivedHttpError: (controller, resource, response) async {
                            if (response.statusCode == 401 || response.statusCode == 403) {
                              homePageController.updateProfile();
                              homePageController.loadFirstBaseSiteRoute();
                            }
                          },
                          pullToRefreshController: homePageController.pullToRefreshController,
                          onLoadStart: homePageController.onLoadStart,
                          onLoadStop: homePageController.onLoadStop,
                          shouldOverrideUrlLoading: homePageController.shouldOverrideUrlLoading,
                          onProgressChanged: homePageController.onProgressChanged,
                          onDownloadStartRequest: homePageController.onDownloadStartRequest,
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
                        width: homePageController.isNarrowAppBar.value ? Get.width - 60 : Get.width - 5,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: homePageController.navbar != null
                  ? ValueListenableBuilder(
                      valueListenable: homePageController.navBarIndexNotifier,
                      builder: (_, currentIndex, __) {
                        return BottomNavigationBar(
                          backgroundColor: null,
                          currentIndex: currentIndex!,
                          onTap: (index) {
                            homePageController.navBarIndexNotifier.value = index;
                            homePageController.loadBaseSiteRoute(route: homePageController.navbar![index].route);
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
                    )
                  : null,
            ),
            if (!homePageController.internetConnected.value)
              Scaffold(
                body: Padding(
                  padding: pagePadding,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/onboarding/connection_error.svg'),
                        const Text(
                          'Отсутствует подключение к интернету.',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            foregroundColor: MaterialStateProperty.all(KivachColors.green),
                            overlayColor: MaterialStateProperty.all(KivachColors.green.withOpacity(0.1)),
                          ),
                          onPressed: () {
                            homePageController.webViewController?.goBack();
                            homePageController.internetConnected(true);
                          },
                          child: const Text(
                            'Обновить',
                            // style: TextStyle(color: KivachColors.green),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
