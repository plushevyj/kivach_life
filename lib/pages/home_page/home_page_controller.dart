import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePageController extends GetxController {
  final canGoBack = false.obs;
  final canGoForward = false.obs;
  final isInternalSite = true.obs;
}