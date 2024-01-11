import 'package:doctor/core/themes/light_theme.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ValueNotifier;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '/models/configuration_models/configuration_of_app/configuration_of_app.dart';
import '/models/configuration_models/navbar_menu/navbar_menu.dart';
import '/models/profile/profile_model.dart';
import '/modules/account/controllers/account_controller.dart';
import '/modules/account/controllers/avatar_controller.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '/modules/authentication/repository/login_repository.dart';
import '/modules/authentication/repository/token_repository.dart';
import '/modules/download_document/handler/download_document_handler.dart';
import '/modules/opening_app/controllers/configuration_of_app_controller.dart';

class HomePageController extends GetxController {
  InAppWebViewController? webViewController;

  final canGoBack = false.obs;
  final isNarrowAppBar = true.obs;
  final progress = 0.0.obs;
  final internetConnected = true.obs;

  final configController = Get.find<ConfigurationOfAppController>();
  final ConfigurationOfApp? appConfiguration =
      Get.find<ConfigurationOfAppController>().configuration.value;
  final Profile? profile = Get.find<AccountController>().profile.value;
  PullToRefreshController? pullToRefreshController;

  late final List<NavbarMenu>? navbar;
  final ValueNotifier<int?> navBarIndexNotifier = ValueNotifier(0);

  @override
  void onInit() async {
    navbar = appConfiguration?.NAVBAR
        .firstWhereOrNull(
            (navbarModel) => profile!.roles.contains(navbarModel.role))
        ?.menu;
    loadFirstBaseSiteRoute();
    configController.payloadRoute.listen((route) {
      if (route != null) {
        loadBaseSiteRoute(route: route);
        configController.payloadRoute.value = null;
      }
    });
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        enabled: true,
        color: KivachColors.green,
      ),
      onRefresh: () async {
        if (GetPlatform.isAndroid) {
          webViewController?.reload();
        } else if (GetPlatform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    progress.listen((value) {
      if (value >= 1) {
        progress.value = 0;
      }
    });
    super.onInit();
  }

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
    configController.payloadRoute.value = null;
  }

  void onLoadStart(InAppWebViewController controller, Uri? uri) {
    if (uri != null) {
      if (uri.origin == configController.configuration.value?.BASE_URL) {
        isNarrowAppBar(true);
      } else {
        isNarrowAppBar(false);
      }
    }
  }

  void onLoadStop(InAppWebViewController controller, Uri? uri) async {
    if (uri != null) {
      if (uri.origin == configController.configuration.value?.BASE_URL) {
        final history = await controller.getCopyBackForwardList();
        final lastRoute = history?.list?.last;
        final previousRoute = history!.list!.length > 1
            ? history.list![history.list!.length - 2]
            : null;
        final checkProfileRoute = [previousRoute, lastRoute]
            .any((route) => route?.url?.path.startsWith('/profile') ?? false);
        if (checkProfileRoute) {
          updateProfile();
        }
        navBarIndexNotifier.value = navbar?.lastIndexWhere(
          (navbarElement) => uri.path.startsWith(navbarElement.route),
        );
      }
      canGoBack.value = (await webViewController?.canGoBack())!;
    }
    pullToRefreshController?.endRefreshing();
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action) async {
    action.request.headers?.addAll(
      {'User-Agent': FkUserAgent.userAgent ?? 'Unknown'},
    );
    if (action.request.url != null) {
      if (action.request.url!.origin ==
          configController.configuration.value?.BASE_URL) {
        if (action.request.url!.path == '/login') {
          logOut();
          return NavigationActionPolicy.CANCEL;
        }
      }
      if (action.request.url.toString().startsWith('tel:') ||
          (action.request.url!
              .toString()
              .startsWith('https://apps.apple.com')) ||
          (action.request.url!
              .toString()
              .startsWith('https://play.google.com'))) {
        launchUrl(action.request.url!);
        return NavigationActionPolicy.CANCEL;
      }
      final listOfAllowedURLs = [
        configController.configuration.value?.BASE_URL,
        ...?configController.configuration.value?.ALLOWED_EXTERNAL_URLS,
        ...?configController.configuration.value?.INTENT_BROWSABLE_URIS,
      ];
      if (listOfAllowedURLs.contains(action.request.url?.origin)) {
        return NavigationActionPolicy.ALLOW;
      }
    }
    return NavigationActionPolicy.CANCEL;
  }

  void onProgressChanged(InAppWebViewController controller, int progressValue) {
    progress.value = progressValue.toDouble() / 100;
  }

  void onDownloadStartRequest(InAppWebViewController controller,
      DownloadStartRequest downloadStartRequest) async {
    await DownloadDocumentHandler().downloadFile(
      url: downloadStartRequest.url,
      showProgressAlert: true,
    );
  }

  void updateProfile() async {
    final profile = await const LoginRepository().getProfile();
    Get.find<AccountController>().profile(profile);
    Get.find<AvatarController>().onInit();
  }
}
