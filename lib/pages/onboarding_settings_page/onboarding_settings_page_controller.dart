import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/onboarding_info/onboarding_info.dart';
import '../../modules/local_authentication/repository/local_authentication_repository.dart';

class OnboardingSettingsPageController extends GetxController {
  static const animationDurationInMilliseconds = 300;

  final pageController = PageController();
  final localAuthenticationRepository = const LocalAuthenticationRepository();
  final currentPage = 0.0.obs;
  late final bool canAuthenticateByBiometric;

  @override
  void onInit() async {
    checkBiometricSetting();
    pageController.addListener(() {
      currentPage(pageController.page);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void checkBiometricSetting() async {
    canAuthenticateByBiometric =
        await localAuthenticationRepository.canAuthenticateByBiometric();
  }
}
