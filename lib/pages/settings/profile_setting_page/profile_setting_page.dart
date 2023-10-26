import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/src/android_webview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../core/themes/light_theme.dart';
import '../../../models/token_model/token_model.dart';
import '../../../modules/authentication/repository/token_repository.dart';
import '../../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import 'profile_settings_page_controller.dart';

import 'package:image_picker/image_picker.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingPage({super.key});

  final configuration =
      Get.find<ConfigurationOfAppController>().configuration.value;

  late final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileSettingsPageController());
    PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();
    var androidNavigationDelegate = AndroidNavigationDelegate(
        const PlatformNavigationDelegateCreationParams());
    androidNavigationDelegate.androidDownloadListener.onDownloadStart;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams
          .fromPlatformWebViewControllerCreationParams(
        params,
      );
      webViewController = WebViewController.fromPlatformCreationParams(params,
          onPermissionRequest: (request) {});
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      final androidWebViewController =
          (WebViewPlatform.instance as AndroidWebViewPlatform)
              .createPlatformWebViewController(params);
      androidWebViewController
        ..setPlatformNavigationDelegate(androidNavigationDelegate)
        ..setMediaPlaybackRequiresUserGesture(true)
        ..setOnShowFileSelector((params) async {
          final selectedPickerSource = await selectPickerSource();
          return selectedPickerSource != null
              ? await showImagePicker(
                  params: params, source: selectedPickerSource)
              : [];
        })
        ..setOnPlatformPermissionRequest(
            (PlatformWebViewPermissionRequest request) {
          print(request.types);
        });
      webViewController =
          WebViewController.fromPlatform(androidWebViewController);
    }
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) async {
            final response =
                await webViewController.runJavaScriptReturningResult(
                    'document.documentElement.innerText');
          },
          onWebResourceError: (error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('${configuration!.BASE_URL}/profile')) {
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
          actionsPadding: const EdgeInsets.symmetric(vertical: 10),
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
