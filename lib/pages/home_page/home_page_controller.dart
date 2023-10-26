import 'package:doctor/models/token_model/token_model.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../core/http/http.dart';
import '../../models/configuration_models/configuration_of_app/configuration_of_app.dart';
import '../../models/profile/profile_model.dart';
import '../../modules/account/controllers/account_controller.dart';
import '../../modules/authentication/repository/token_repository.dart';
import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';

class HomePageController extends GetxController {
  final canGoBack = false.obs;
  final canGoForward = false.obs;
  final isNarrowAppBar = true.obs;

  final configController = Get.find<ConfigurationOfAppController>();
  final ConfigurationOfApp? appConfiguration =
      Get.find<ConfigurationOfAppController>().configuration.value;
  final Profile? profile = Get.find<AccountController>().profile.value;

  @override
  void onInit() async {
    // final kek = await TokenRepository().getRefreshToken();
    // TokenRepository()
    //     .saveTokens(token: TokenModel(token: 'edfdfdfdf', refresh_token: kek!));
    // addAccessToken();
    webViewController.loadRequest(
        Uri.parse('https://docs.flutter.dev/get-started/install/linux'));
    // load(route: configController.payloadRoute.value ?? '/');
    configController.payloadRoute.value = null;
    configController.payloadRoute.listen((route) {
      if (route != null) {
        load(route: route);
        configController.payloadRoute.value = null;
      }
    });
    super.onInit();
  }

  static PlatformWebViewControllerCreationParams params = (() {
    if (GetPlatform.isIOS) {
      return const PlatformWebViewControllerCreationParams();
    } else {
      return WebViewPlatform.instance is WebKitWebViewPlatform
          ? WebKitWebViewControllerCreationParams(
              allowsInlineMediaPlayback: true,
              mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
          : const PlatformWebViewControllerCreationParams();
    }
  })();

  final webViewController = WebViewController.fromPlatformCreationParams(
    params,
    onPermissionRequest: (request) {
      request.grant();
    },
  );

  void load({required String route}) async {
    String? accessToken = await const TokenRepository().getAccessToken();
    final headers = {
      'X-Auth': 'Bearer $accessToken',
    };
    webViewController.loadRequest(
      Uri.parse('${appConfiguration?.BASE_URL}$route'),
      headers: headers,
    );
  }

  void refreshTokensByContentInWebView(String content) {}
}
