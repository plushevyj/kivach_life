import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/local_authentication/repository/local_authentication_repository.dart';
import '../settings/new_local_password_page/new_password_controller.dart';

class OnboardingSettingsPageController extends GetxController {
  static const animationDurationInMilliseconds = 300;

  final pageController = PageController();
  final localAuthenticationRepository = const LocalAuthenticationRepository();
  final newLocalPasswordController = Get.put(NewLocalPasswordController());
  final currentPage = 0.0.obs;

  String? proofPassword;

  late final bool canAuthenticateByBiometric;

  @override
  void onInit() async {
    checkBiometricSetting();
    newLocalPasswordController.secondPassword.addListener(() {
      print(newLocalPasswordController.secondPassword.text);
      if (newLocalPasswordController.firstPassword.text ==
          newLocalPasswordController.secondPassword.text) {
        proofPassword = newLocalPasswordController.secondPassword.text;
        print('proofPassword = $proofPassword');
        print(newLocalPasswordController.firstPassword.text ==
            newLocalPasswordController.secondPassword.text);
      }
    });
    pageController.addListener(() {
      currentPage(pageController.page);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    newLocalPasswordController.dispose();
    currentPage.close();
    super.dispose();
  }

  void checkBiometricSetting() async {
    canAuthenticateByBiometric =
        await localAuthenticationRepository.canAuthenticateByBiometric();
  }
}
