import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/core/themes/light_theme.dart';
import '/modules/authentication/repository/token_repository.dart';
import 'home_page_controller.dart';
import 'layout/body/body_for_large_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static PlatformWebViewControllerCreationParams params =
      // WebViewPlatform.instance is WebKitWebViewPlatform
      // ? WebKitWebViewControllerCreationParams(
      //     allowsInlineMediaPlayback: true,
      //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
      // :
      const PlatformWebViewControllerCreationParams();

  final webViewController = WebViewController.fromPlatformCreationParams(
    params,
    onPermissionRequest: (request) {
      request.grant();
    },
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    final navBarIndexNotifier = ValueNotifier(0);
    final homePageController = Get.put(HomePageController());
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            homePageController
                .isInternalSite(url.startsWith(dotenv.get('BASE_URL')));
          },
          onPageFinished: (url) async {
            homePageController.canGoBack(await webViewController.canGoBack());
            homePageController
                .canGoForward(await webViewController.canGoForward());
            if (url == '${dotenv.get('BASE_URL')}/') {
              navBarIndexNotifier.value = 0;
            } else if (url.startsWith('${dotenv.get('BASE_URL')}/schedule')) {
              navBarIndexNotifier.value = 1;
            } else if (url.startsWith('${dotenv.get('BASE_URL')}/chat')) {
              navBarIndexNotifier.value = 2;
            }
          },
          onNavigationRequest: (request) async {
            if (request.url.startsWith('tel:') ||
                (request.url.startsWith('https://apps.apple.com')) ||
                (request.url.startsWith('https://play.google.com'))) {
              launchUrl(Uri.parse(request.url));
            }
            if (request.url.startsWith(dotenv.get('BASE_URL')) ||
                (request.url.startsWith('https://info.kivach.ru')) ||
                (request.url.startsWith('https://kivach.diet')) ||
                (request.url.startsWith('https://lecture.kivach.ru')) ||
                (request.url.startsWith('https://kivach.ru')) ||
                (request.url.startsWith('https://kivachlab.ru')) ||
                (request.url.startsWith('https://www.youtube.com'))) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      );
    load(route: '/');
    return Scaffold(
      extendBodyBehindAppBar: !isSmallScreen,
      backgroundColor: const Color(0xFFF3F5F6),
      // appBar: isSmallScreen
      //     ? AppBarForSmallScreen(
      //         webViewController: webViewController,
      //         homePageController: homePageController,
      //       )
      //     : null,
      body: isSmallScreen
          ? BodyForLargeScreen(
              homePageController: homePageController,
              webViewController: webViewController,
            )
          : BodyForLargeScreen(
              homePageController: homePageController,
              webViewController: webViewController,
            ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: navBarIndexNotifier,
        builder: (_, currentIndex, __) {
          return BottomNavigationBar(
            backgroundColor: null,
            currentIndex: currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  navBarIndexNotifier.value = index;
                  load(route: '/');
                case 1:
                  navBarIndexNotifier.value = index;
                  load(route: '/schedule');
                case 2:
                  navBarIndexNotifier.value = index;
                  load(route: '/chat');
              }
            },
            enableFeedback: false,
            selectedIconTheme: const IconThemeData(size: 24),
            unselectedIconTheme: const IconThemeData(size: 24),
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            selectedItemColor: KivachColors.green,
            unselectedItemColor: const Color(0xFFAEB2BA),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Расписание',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Чат',
              ),
            ],
          );
        },
      ),
    );
  }

  void load({required String route}) async {
    String? accessToken = await const TokenRepository().getAccessToken();
    final headers = {
      // 'X-Auth': 'Bearer $accessToken',
      'X-Auth': 'Bearer $accessToken',
    };
    webViewController.loadRequest(Uri.parse('${dotenv.get('BASE_URL')}$route'),
        headers: headers);
  }
}
