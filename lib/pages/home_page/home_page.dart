import 'dart:io';

import 'package:doctor/core/themes/light_theme.dart';
import 'package:doctor/modules/authentication/repository/token_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    final navBarIndexNotifier = ValueNotifier(0);
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
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
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F6),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.statusBarHeight / context.mediaQuery.devicePixelRatio),
            child: WebViewWidget(
              controller: webViewController,
            ),
          ),
          Positioned(
            top: 75,
            child: IconButton(
              onPressed: () => webViewController.goBack(),
              icon: Icon(Platform.isIOS
                  ? Icons.arrow_back_ios
                  : Icons.arrow_back_outlined),
            ),
          ),
        ],
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
                case 3:
                  Get.toNamed('/settings');
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
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
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
      'X-Auth': 'Bearer $accessToken',
    };
    webViewController.loadRequest(Uri.parse('${dotenv.get('BASE_URL')}$route'),
        headers: headers);
  }
}
