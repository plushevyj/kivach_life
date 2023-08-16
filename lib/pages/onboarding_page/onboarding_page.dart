import 'package:doctor/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page_controller.dart';

final onboardingButtonStyle = ButtonStyle(
  textStyle: MaterialStateProperty.all(
    const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
  foregroundColor: MaterialStateProperty.all(KivachColors.green),
  overlayColor: MaterialStateProperty.all(KivachColors.green.withOpacity(0.2)),
);

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
              onPressed: () {
                Get.back(canPop: false);
              },
              child: const Text('Пропустить'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          itemCount: onboardingController.onboardingPagesList.length,
          controller: onboardingController.pageController,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      onboardingController.onboardingPagesList[index].image),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      onboardingController.onboardingPagesList[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 80,
        child: SmoothPageIndicator(
          onDotClicked: (index) {
            onboardingController.pageController.animateToPage(
              index,
              duration: Duration(
                  milliseconds: ((onboardingController.pageController.page!
                                      .toInt() -
                                  index)
                              .abs() *
                          OnboardingController.animationDurationInMilliseconds)
                      .toInt()),
              curve: Curves.ease,
            );
          },
          effect: const ExpandingDotsEffect(
              expansionFactor: 2, activeDotColor: KivachColors.green),
          controller: onboardingController.pageController,
          count: onboardingController.onboardingPagesList.length,
        ),
      ),
    );
  }
}
