import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    super.onInit();
  }
}
