import 'package:doctor/core/themes/light_theme.dart';
import 'package:doctor/modules/authentication/repository/token_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/layout/custom_appbar.dart';

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
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (WebResourceError error) {
            print('webview error = $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(dotenv.get('BASE_URL')) ||
                (request.url.startsWith('https://info.kivach.ru'))) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      );
    load(route: '/');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F5F6),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: Stack(
            children: [
              WebViewWidget(
                controller: webViewController,
              ),
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: CustomAppBar(webViewController: webViewController),
              // ),
            ],
          ),
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
                  // case 3:
                  //   Get.toNamed('/settings');
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
      ),
    );
  }

  void load({required String route}) async {
    String? accessToken = await const TokenRepository().getAccessToken();
    final headers = {
      'X-Auth': 'Bearer $accessToken',
    };
    webViewController.loadRequest(Uri.parse('${dotenv.get('BASE_URL')}$route'),
        headers: headers);
  }
}
