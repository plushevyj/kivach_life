import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../core/themes/light_theme.dart';
import '../../../modules/authentication/repository/token_repository.dart';
import '../../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import 'profile_settings_page_controller.dart';

import 'package:image_picker/image_picker.dart';

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
      final androidWebViewController =
          (WebViewPlatform.instance as AndroidWebViewPlatform)
              .createPlatformWebViewController(params);
      androidWebViewController
        ..setMediaPlaybackRequiresUserGesture(true)
        ..setOnShowFileSelector((params) async {
          final selectedPickerSource = await selectPickerSource();
          return selectedPickerSource != null
              ? await showImagePicker(
                  params: params, source: selectedPickerSource)
              : [];
        });
      webViewController =
          WebViewController.fromPlatform(androidWebViewController);
    }
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
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

  Future<ImageSource?> selectPickerSource() async {
    return showDialog<ImageSource>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 50),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: KivachColors.green),
              onPressed: () => Get.back(result: ImageSource.camera),
              child: const Text('Сделать снимок'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: KivachColors.green,
                minimumSize: const Size(30, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () => Get.back(result: ImageSource.gallery),
              child: const Text('Выбрать из галереи'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> showImagePicker({
    required FileSelectorParams params,
    required ImageSource source,
  }) async {
    if (params.acceptTypes.any((type) => type == 'image/*')) {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      if (image == null) {
        return [];
      }
      final imageData = await image.readAsBytes();
      final filePath = (await getTemporaryDirectory())
          .uri
          .resolve('./image_${DateTime.now().microsecondsSinceEpoch}.jpg');
      final file = await File.fromUri(filePath).create(recursive: true);
      await file.writeAsBytes(imageData, flush: true);
      return [file.uri.toString()];
    }
    return [];
  }
}
