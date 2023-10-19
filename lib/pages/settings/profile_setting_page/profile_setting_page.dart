import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../modules/authentication/repository/token_repository.dart';
import '../../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import 'profile_settings_page_controller.dart';

import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

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
      webViewController = WebViewController.fromPlatformCreationParams(params,
          onPermissionRequest: (request) {
        print('request.types = ${request.types}');
      });
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      print(
          'WebViewPlatform.instance is AndroidWebViewPlatform = ${WebViewPlatform.instance is AndroidWebViewPlatform}');
      final androidWebViewController =
          (WebViewPlatform.instance as AndroidWebViewPlatform)
              .createPlatformWebViewController(params);
      androidWebViewController
        ..setMediaPlaybackRequiresUserGesture(true)
        ..setOnShowFileSelector((params) async {
          if (params.acceptTypes.any((type) => type == 'image/*')) {
            final picker = image_picker.ImagePicker();
            final photo = await picker.pickImage(
                source: image_picker.ImageSource.gallery);

            if (photo == null) {
              return [];
            }

            final imageData = await photo.readAsBytes();
            final decodedImage = image.decodeImage(imageData)!;
            final scaledImage = image.copyResize(decodedImage, width: 500);
            final jpg = image.encodeJpg(scaledImage, quality: 90);

            final filePath = (await getTemporaryDirectory()).uri.resolve(
                  './image_${DateTime.now().microsecondsSinceEpoch}.jpg',
                );
            final file = await File.fromUri(filePath).create(recursive: true);
            await file.writeAsBytes(jpg, flush: true);

            return [file.uri.toString()];
          }

          return [];
        });
      // params = androidWebViewController.params;
      webViewController =
          WebViewController.fromPlatform(androidWebViewController);
    }
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
