// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../modules/authentication/repository/login_repository.dart';
// import '/core/themes/light_theme.dart';
// import 'home_page_controller.dart';
// import 'layout/body/body_for_large_screen.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // const TokenRepository().saveTokens(
//     //     token: TokenModel(token: 'efdfdfdf', refresh_token: 'dfdfdfdfdf'));
//     // addAccessToken();
//     final homePageController = Get.put(HomePageController());
//     final navbar = homePageController.appConfiguration?.NAVBAR
//         .firstWhere((navbarModel) =>
//             homePageController.profile!.roles.contains(navbarModel.role))
//         .menu;
//     WidgetsBinding.instance
//         .addPostFrameCallback((_) => FlutterNativeSplash.remove());
//     final navBarIndexNotifier = ValueNotifier(0);
//     homePageController.webViewController
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..enableZoom(false)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             homePageController.isNarrowAppBar(url.startsWith(
//                     homePageController.appConfiguration!.BASE_URL) &&
//                 !url.startsWith(
//                     '${homePageController.appConfiguration!.BASE_URL}/chat') &&
//                 !url.startsWith(
//                     '${homePageController.appConfiguration!.BASE_URL}/kivach-analysis'));
//           },
//           onPageFinished: (url) async {
//             try {
//               final result = await homePageController.webViewController
//                   .runJavaScriptReturningResult(
//                       'document.documentElement.innerText');
//               final code = jsonDecode(jsonDecode(result.toString()))['code'];
//               if (code == 401 || code == 403) {
//                 print(jsonDecode(jsonDecode(result.toString())));
//                 final res = await const LoginRepository().logInByToken();
//                 homePageController.webViewController
//                     .loadRequest(Uri.parse(url));
//               }
//             } catch (_) {}
//
//             homePageController.canGoBack(
//                 await homePageController.webViewController.canGoBack());
//             homePageController.canGoForward(
//                 await homePageController.webViewController.canGoForward());
//             final currentRoute =
//                 url.split(homePageController.appConfiguration!.BASE_URL)[1];
//             navBarIndexNotifier.value = navbar!.lastIndexWhere(
//               (navbarElement) => currentRoute.startsWith(navbarElement.route),
//             );
//           },
//           onWebResourceError: (error) {
//             print('error = $error');
//           },
//           onNavigationRequest: (request) async {
//             print('request.url = ${request.url}');
//             if (request.url.startsWith('tel:') ||
//                 (request.url.startsWith('https://apps.apple.com')) ||
//                 (request.url.startsWith('https://play.google.com'))) {
//               launchUrl(Uri.parse(request.url));
//               return NavigationDecision.prevent;
//             }
//             for (var url in [
//               ...[
//                 for (var browsableUrl in homePageController
//                     .appConfiguration!.INTENT_BROWSABLE_URIS)
//                   '${browsableUrl.scheme}${browsableUrl.host}',
//               ],
//               ...?homePageController.appConfiguration?.ALLOWED_EXTERNAL_URLS
//             ]) {
//               if (request.url.startsWith(url)) {
//                 return NavigationDecision.navigate;
//               }
//             }
//             return NavigationDecision.prevent;
//           },
//         ),
//       );
//     return WillPopScope(
//       onWillPop: () async {
//         homePageController.webViewController.goBack();
//         return false;
//       },
//       child: Scaffold(
//         extendBodyBehindAppBar: !isSmallScreen,
//         backgroundColor: const Color(0xFFF3F5F6),
//         body: BodyForLargeScreen(
//           homePageController: homePageController,
//           webViewController: homePageController.webViewController,
//         ),
//         bottomNavigationBar: ValueListenableBuilder(
//           valueListenable: navBarIndexNotifier,
//           builder: (_, currentIndex, __) {
//             return BottomNavigationBar(
//               backgroundColor: null,
//               currentIndex: currentIndex,
//               onTap: (index) {
//                 navBarIndexNotifier.value = index;
//                 homePageController.load(route: navbar[index].route);
//               },
//               enableFeedback: false,
//               selectedIconTheme: const IconThemeData(size: 24),
//               unselectedIconTheme: const IconThemeData(size: 24),
//               selectedLabelStyle: const TextStyle(fontSize: 12),
//               unselectedLabelStyle: const TextStyle(fontSize: 12),
//               selectedItemColor: KivachColors.green,
//               unselectedItemColor: const Color(0xFFAEB2BA),
//               type: BottomNavigationBarType.fixed,
//               items: navbar!
//                   .map(
//                     (element) => BottomNavigationBarItem(
//                       // Icons.home_outlined
//                       icon: Icon(
//                         IconData(
//                           int.parse(element.icon),
//                           fontFamily: 'MaterialIcons',
//                         ),
//                       ),
//                       label: element.label,
//                     ),
//                   )
//                   .toList(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/modules/account/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/themes/light_theme.dart';
import '../../modules/account/controllers/avatar_controller.dart';
import '../../modules/authentication/repository/login_repository.dart';
import 'home_page_controller.dart';
import 'layout/app_bar/app_bar_for_large_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    final navbar = homePageController.appConfiguration?.NAVBAR
        .firstWhere((navbarModel) =>
            homePageController.profile!.roles.contains(navbarModel.role))
        .menu;
    final navBarIndexNotifier = ValueNotifier(0);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    return WillPopScope(
      onWillPop: () async {
        homePageController.webViewController?.goBack();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useOnDownloadStart: true,
                    supportZoom: true,
                    preferredContentMode: UserPreferredContentMode.MOBILE,
                  ),
                  android: AndroidInAppWebViewOptions(
                    builtInZoomControls: false,
                  ),
                ),
                onWebViewCreated: (controller) {
                  homePageController
                    ..webViewController = controller
                    ..loadFirstBaseSiteRoute();
                },
                onLoadStart: (controller, uri) {},
                onLoadStop: (controller, uri) async {
                  if (uri != null) {
                    if (uri.path.startsWith('/profile')) {
                      final profile =
                          await const LoginRepository().getProfile();
                      Get.find<AccountController>().profile(profile);
                      Get.find<AvatarController>().onInit();
                    }
                    homePageController.canGoBack(await homePageController
                        .webViewController
                        ?.canGoBack());
                    homePageController.canGoForward(await homePageController
                        .webViewController
                        ?.canGoForward());
                    navBarIndexNotifier.value = navbar!.lastIndexWhere(
                      (navbarElement) =>
                          uri.path.startsWith(navbarElement.route),
                    );
                  }
                },
                onProgressChanged: (controller, progress) async {
                  homePageController.progress.value = progress.toDouble();
                },
                onDownloadStartRequest: (controller, uri) async {
                  // final task = await FlutterDownloader.enqueue(
                  //   headers: await homePageController.getHeaders(),
                  //   url: '${uri.url.origin}${uri.url.path}',
                  //   savedDir: await (() async {
                  //     if (GetPlatform.isAndroid) {
                  //       return '/storage/emulated/0/Download';
                  //     } else if (GetPlatform.isIOS) {
                  //       print('ios');
                  //       return (await getLibraryDirectory()).path;
                  //     }
                  //     return (await getDownloadsDirectory())!.path;
                  //   })(),
                  //   showNotification: true,
                  //   openFileFromNotification: true,
                  //   saveInPublicStorage: true,
                  // );
                  // if (task != null) {
                  //   FlutterDownloader.open(taskId: task);
                  // }
                  var dir = await getApplicationDocumentsDirectory();
                  // print('${uri.url.origin}${uri.url.path}');
                  // print('/storage/emulated/0/Download/Kivach');
                  final result = await Dio().download(
                      '${uri.url.origin}${uri.url.path}',
                      GetPlatform.isAndroid
                          ? '/storage/emulated/0/Download/Kivach/${uri.url.path.split('/').last}'
                          : '${(await getDownloadsDirectory())!.path}/${uri.url.path.split('/').last}',
                      onReceiveProgress: (count, total) {
                    print('Rec: $count , Total: $total');
                  });
                },
              ),
              AppBarForLargeScreen(
                homePageController: homePageController,
                width: homePageController.isNarrowAppBar.value
                    ? Get.width - 60
                    : Get.width - 5,
              ),

              // Positioned(
              //   top: kToolbarHeight,
              //   child: Obx(
              //     () => LinearProgressIndicator(
              //       value: homePageController.progress.value,
              //     ),
              //   ),
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
                navBarIndexNotifier.value = index;
                homePageController.loadBaseSiteRoute(
                    route: navbar[index].route);
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
