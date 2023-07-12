import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlTitleNotifier = ValueNotifier('');
    final navBarIndexNotifier = ValueNotifier(0);
    final loadingNotifier = ValueNotifier<int?>(null);
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            loadingNotifier.value = progress;
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://doctors.kivach.ru/')) {
              urlTitleNotifier.value = request.url;
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://doctors.kivach.ru/'));
    urlTitleNotifier.value = 'https://doctors.kivach.ru/';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: ValueListenableBuilder(
            valueListenable: loadingNotifier,
            builder: (_, loadingValue, __) {
              return loadingValue != null && loadingValue != 100
                  ? LinearProgressIndicator(
                      minHeight: 2,
                      value: loadingValue.toDouble(),
                      color: const Color(0xFF38A381),
                    )
                  : const SizedBox(height: 2);
            },
          ),
        ),
        leading: IconButton(
          onPressed: () => webViewController.goBack(),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: ValueListenableBuilder(
          valueListenable: urlTitleNotifier,
          builder: (_, url, __) {
            return Text(url);
          },
        ),
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
                  webViewController
                      .loadRequest(Uri.parse('https://doctors.kivach.ru/'));
                case 1:
                  navBarIndexNotifier.value = index;
                  webViewController.loadRequest(
                      Uri.parse('https://doctors.kivach.ru/schedule/'));
                case 2:
                  navBarIndexNotifier.value = index;
                  webViewController.loadRequest(
                      Uri.parse('https://doctors.kivach.ru/chat/'));
                case 3:
                  Get.toNamed('/settings');
              }
            },
            selectedIconTheme: const IconThemeData(size: 24),
            unselectedIconTheme: const IconThemeData(size: 24),
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            selectedItemColor: const Color(0xFF38A381),
            unselectedItemColor: const Color(0xFFAEB2BA),
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
}
