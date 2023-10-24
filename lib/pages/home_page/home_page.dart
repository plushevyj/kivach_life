import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/core/themes/light_theme.dart';
import 'home_page_controller.dart';
import 'layout/body/body_for_large_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    final navbar = homePageController.appConfiguration?.NAVBAR
        .firstWhere((navbarModel) =>
            homePageController.profile!.roles.contains(navbarModel.role))
        .menu;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    final navBarIndexNotifier = ValueNotifier(0);
    homePageController.webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            homePageController.isNarrowAppBar(url.startsWith(
                    homePageController.appConfiguration!.BASE_URL) &&
                !url.startsWith(
                    '${homePageController.appConfiguration!.BASE_URL}/chat'));
          },
          onPageFinished: (url) async {
            homePageController.canGoBack(
                await homePageController.webViewController.canGoBack());
            homePageController.canGoForward(
                await homePageController.webViewController.canGoForward());
            final currentRoute =
                url.split(homePageController.appConfiguration!.BASE_URL)[1];
            navBarIndexNotifier.value = navbar!.lastIndexWhere(
                (navbarElement) =>
                    currentRoute.startsWith(navbarElement.route));
          },
          onNavigationRequest: (request) async {
            print('request.url = ${request.url}');
            if (request.url.startsWith('tel:') ||
                (request.url.startsWith('https://apps.apple.com')) ||
                (request.url.startsWith('https://play.google.com'))) {
              launchUrl(Uri.parse(request.url));
              return NavigationDecision.prevent;
            }
            for (var url in [
              ...[
                for (var browsableUrl in homePageController
                    .appConfiguration!.INTENT_BROWSABLE_URIS)
                  '${browsableUrl.scheme}${browsableUrl.host}',
              ],
              ...?homePageController.appConfiguration?.ALLOWED_EXTERNAL_URLS
            ]) {
              if (request.url.startsWith(url)) {
                return NavigationDecision.navigate;
              }
            }
            return NavigationDecision.prevent;
          },
        ),
      );
    return WillPopScope(
      onWillPop: () async {
        homePageController.webViewController.goBack();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: !isSmallScreen,
        backgroundColor: const Color(0xFFF3F5F6),
        body: BodyForLargeScreen(
          homePageController: homePageController,
          webViewController: homePageController.webViewController,
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: navBarIndexNotifier,
          builder: (_, currentIndex, __) {
            return BottomNavigationBar(
              backgroundColor: null,
              currentIndex: currentIndex,
              onTap: (index) {
                navBarIndexNotifier.value = index;
                homePageController.load(route: navbar[index].route);
              },
              enableFeedback: false,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 24),
              selectedLabelStyle: const TextStyle(fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              selectedItemColor: KivachColors.green,
              unselectedItemColor: const Color(0xFFAEB2BA),
              type: BottomNavigationBarType.fixed,
              items: navbar!
                  .map(
                    (element) => BottomNavigationBarItem(
                      // Icons.home_outlined
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
