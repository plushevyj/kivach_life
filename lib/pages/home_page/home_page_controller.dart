import 'package:doctor/models/token_model/token_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../core/http/http.dart';
import '../../models/configuration_models/configuration_of_app/configuration_of_app.dart';
import '../../models/profile/profile_model.dart';
import '../../modules/account/controllers/account_controller.dart';
import '../../modules/authentication/repository/token_repository.dart';
import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';

class HomePageController extends GetxController {
  InAppWebViewController? webViewController;

  final canGoBack = false.obs;
  final canGoForward = false.obs;
  final isNarrowAppBar = true.obs;
  final progress = 0.0.obs;

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

    // load(route: configController.payloadRoute.value ?? '/');
    configController.payloadRoute.value = null;
    configController.payloadRoute.listen((route) {
      if (route != null) {
        loadBaseSiteRoute(route: route);
        configController.payloadRoute.value = null;
      }
    });
    super.onInit();
  }

  // static PlatformWebViewControllerCreationParams params = (() {
  //   if (GetPlatform.isIOS) {
  //     return const PlatformWebViewControllerCreationParams();
  //   } else {
  //     return WebViewPlatform.instance is WebKitWebViewPlatform
  //         ? WebKitWebViewControllerCreationParams(
  //             allowsInlineMediaPlayback: true,
  //             mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
  //         : const PlatformWebViewControllerCreationParams();
  //   }
  // })();

  // final webViewController = WebViewController.fromPlatformCreationParams(
  //   params,
  //   onPermissionRequest: (request) {
  //     request.grant();
  //   },
  // );

  Future<Map<String, String>> getHeaders() async {
    String? accessToken = await const TokenRepository().getAccessToken();
    return {
      'X-Auth': 'Bearer $accessToken',
    };
  }

  void loadFirstBaseSiteRoute() async {
    webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
            '${appConfiguration!.BASE_URL}${configController.payloadRoute.value ?? '/'}'),
        headers: await getHeaders(),
      ),
    );
  }

  void loadBaseSiteRoute({required String route}) {
    webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse('${appConfiguration!.BASE_URL}$route'),
      ),
    );
  }

  // void load({required String route}) async {
  //   String? accessToken = await const TokenRepository().getAccessToken();
  //   final headers = {
  //     'X-Auth': 'Bearer $accessToken',
  //   };
  //   webViewController.loadRequest(
  //     Uri.parse('${appConfiguration?.BASE_URL}$route'),
  //     headers: headers,
  //   );
  // }

  void refreshTokensByContentInWebView(String content) {}
}
