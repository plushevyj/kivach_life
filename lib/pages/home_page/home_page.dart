import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../modules/account/controllers/account_controller.dart';
import '../../modules/account/controllers/avatar_controller.dart';
import '/core/themes/light_theme.dart';
import '/modules/authentication/repository/token_repository.dart';
import 'home_page_controller.dart';

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
    final avatarController = Get.put(AvatarController());
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
      appBar: AppBar(
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
                  Platform.isIOS
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back_outlined,
                  color: homePageController.canGoBack.value
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: homePageController.canGoForward.value
                    ? () => webViewController.goForward()
                    : null,
                icon: Icon(
                  Platform.isIOS
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_forward_outlined,
                  color: homePageController.canGoForward.value
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
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/settings'),
            icon: const Icon(Icons.settings, size: 30),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: webViewController,
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
