import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/core/themes/light_theme.dart';
import '/widgets/inputs/button_for_form.dart';
import '/widgets/onboarding/onboarding_info_widget.dart';
import 'onboarding_greeting_page_controller.dart';

class GreetingOnboardingPage extends StatelessWidget {
  const GreetingOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.put(OnboardingController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 84,
        leading: Obx(
          () => onboardingController.isLastPage.value
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 48,
                  child: TextButton(
                    style: onboardingButtonStyle,
                    onPressed: () {
                      onboardingController.pageController.nextPage(
                        duration: const Duration(
                            milliseconds: OnboardingController
                                .animationDurationInMilliseconds),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text('Далее'),
                  ),
                ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            height: 56,
            child: TextButton(
              style: onboardingButtonStyle,
              onPressed: () => Get.back(),
              child: const Text('Пропустить'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          itemCount: onboardingController.onboardingPagesList.length,
          controller: onboardingController.pageController,
          itemBuilder: (context, index) {
            return OnboardingInfoWidget(
                onboardingInfo:
                    onboardingController.onboardingPagesList[index]);
          },
        ),
      ),
      bottomSheet: Obx(
        () => onboardingController.isLastPage.value
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 30).add(pagePadding),
                child:
                    ButtonForForm(text: 'НАЧАТЬ', onPressed: () => Get.back()),
              )
            : Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                height: 80,
                child: SmoothPageIndicator(
                  onDotClicked: (index) {
                    onboardingController.pageController.animateToPage(
                      index,
                      duration: Duration(
                          milliseconds: ((onboardingController
                                              .pageController.page!
                                              .toInt() -
                                          index)
                                      .abs() *
                                  OnboardingController
                                      .animationDurationInMilliseconds)
                              .toInt()),
                      curve: Curves.ease,
                    );
                  },
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 2,
                    activeDotColor: KivachColors.green,
                  ),
                  controller: onboardingController.pageController,
                  count: onboardingController.onboardingPagesList.length,
                ),
              ),
      ),
    );
  }
}
