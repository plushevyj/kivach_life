import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/onboarding_info/onboarding_info.dart';

class OnboardingController extends GetxController {
  static const animationDurationInMilliseconds = 300;
  final PageController pageController = PageController();
  final isLastPage = false.obs;

  final onboardingPagesList = <OnboardingInfo>[
    const OnboardingInfo(
      title: 'Просматривайте свое расписание',
      image: 'assets/images/onboarding/schedule.svg',
    ),
    const OnboardingInfo(
      title: 'Общайтесь с медперсоналом в чатах',
      image: 'assets/images/onboarding/chat.svg',
    ),
    const OnboardingInfo(
      title: 'Следите за своими анализами и результатами обследований',
      image: 'assets/images/onboarding/result.svg',
    ),
    const OnboardingInfo(
      title: 'Получайте уведомления о назначенных процедурах и лечении',
      image: 'assets/images/onboarding/notification.svg',
    ),
  ];

  @override
  void onInit() {
    pageController.addListener(() {
      isLastPage(pageController.page! >= onboardingPagesList.length - 1.5);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
