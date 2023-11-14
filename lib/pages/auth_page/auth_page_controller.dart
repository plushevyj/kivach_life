import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {
  final isLoading = false.obs;
  final isKeyBoardVisible = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => FlutterNativeSplash.remove());
    KeyboardVisibilityController().onChange.listen((value) {
      isKeyBoardVisible(value);
    });
    super.onInit();
  }
}
