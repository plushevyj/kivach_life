import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../modules/authentication/repository/token_repository.dart';
import '../../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import 'profile_settings_page_controller.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingPage({super.key});

  final configuration =
      Get.find<ConfigurationOfAppController>().configuration.value;

  // static PlatformWebViewControllerCreationParams params = (() {
  //
  //
  //
  //
  //
  //   if (GetPlatform.isIOS) {
  //     return const PlatformWebViewControllerCreationParams();
  //   } else {
  //     // return WebViewPlatform.instance is WebKitWebViewPlatform
  //     //     ? WebKitWebViewControllerCreationParams(
  //     //         allowsInlineMediaPlayback: true,
  //     //         mediaTypesRequiringUserAction: const {
  //     //           PlaybackMediaTypes.audio,
  //     //           PlaybackMediaTypes.video,
  //     //         },
  //     //       )
  //     //     : const PlatformWebViewControllerCreationParams();
  //     // return WebKitWebViewControllerCreationParams(
  //     //   allowsInlineMediaPlayback: true,
  //     //   mediaTypesRequiringUserAction: const {
  //     //     PlaybackMediaTypes.audio,
  //     //     PlaybackMediaTypes.video,
  //     //   },
  //     // );
  //     return const PlatformWebViewControllerCreationParams();
  //   }
  // })();

  // final webViewController = WebViewController.fromPlatformCreationParams(
  //   params,
  //   onPermissionRequest: (request) {
  //     request.grant();
  //   },
  // );

  late final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileSettingsPageController());
    PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams
          .fromPlatformWebViewControllerCreationParams(
        params,
      );
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      params = AndroidWebViewControllerCreationParams
          .fromPlatformWebViewControllerCreationParams(
        params,
      );
    }

    webViewController = WebViewController.fromPlatformCreationParams(params,
        onPermissionRequest: (request) {
      print('request.types = ${request.types}');
    });
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(configuration!.BASE_URL)) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      );
    load(route: '/profile');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки профиля'),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }

  void load({required String route}) async {
    String? accessToken = await const TokenRepository().getAccessToken();

    final headers = {
      'X-Auth': 'Bearer $accessToken',
    };
    webViewController.loadRequest(Uri.parse('${configuration?.BASE_URL}$route'),
        headers: headers);
  }
}
