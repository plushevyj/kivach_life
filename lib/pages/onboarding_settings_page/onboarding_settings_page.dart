import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import '../../modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import '../settings/new_local_password_page/new_local_password_page.dart';
import '/models/onboarding_info/onboarding_info.dart';
import '/widgets/inputs/button_for_form.dart';
import '/widgets/onboarding/onboarding_info_widget.dart';
import '/core/themes/light_theme.dart';
import 'onboarding_settings_page_controller.dart';

class OnboardingSettingsPage extends StatelessWidget {
  const OnboardingSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingSettingsPageController =
        Get.put(OnboardingSettingsPageController());
    return BlocListener<LocalPasswordSettingBloc, LocalPasswordSettingState>(
      listener: (context, state) {
        if (state is SuccessfulPasswordChange) {
          if (onboardingSettingsPageController.canAuthenticateByBiometric) {
            onboardingSettingsPageController.pageController.nextPage(
              duration: const Duration(
                  milliseconds: OnboardingSettingsPageController
                      .animationDurationInMilliseconds),
              curve: Curves.ease,
            );
          } else {
            Get.back();
          }
        } else if (state is ProofedOfIdentity) {
          onboardingSettingsPageController.pageController.animateToPage(
            1,
            duration: const Duration(
                milliseconds: OnboardingSettingsPageController
                    .animationDurationInMilliseconds),
            curve: Curves.ease,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 84,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              height: 56,
              child: TextButton(
                style: onboardingButtonStyle,
                onPressed: () {},
                child: const Text('Пропустить'),
              ),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: onboardingSettingsPageController.pageController,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: OnboardingInfoWidget(
                onboardingInfo: OnboardingInfo(
                  title:
                      'Добавьте цифровой пароль для упрощенного входа в приложение',
                  image: 'assets/images/onboarding/pin-code.svg',
                ),
              ),
            ),
            NewLocalPasswordBody(
                newLocalPasswordController: onboardingSettingsPageController
                    .newLocalPasswordController),
            const Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: OnboardingInfoWidget(
                onboardingInfo: OnboardingInfo(
                  title:
                      'Добавьте настройку входа в приложение по отпечатку пальца или сканеру лица',
                  image: 'assets/images/onboarding/biometrics.svg',
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Obx(
          () {
            if (onboardingSettingsPageController.currentPage.value == 0) {
              return GoToButton(
                onPressed: () {
                  Get.context!
                      .read<LocalPasswordSettingBloc>()
                      .add(const CreatePassword());
                },
              );
            } else if (onboardingSettingsPageController.currentPage.value ==
                2) {
              return GoToButton(
                onPressed: () {
                  Get.context!.read<BiometricSettingsBloc>().add(
                        EnableBiometricsLogin(
                          true,
                          proof: onboardingSettingsPageController.proofPassword,
                        ),
                      );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class GoToButton extends StatelessWidget {
  const GoToButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 30).add(pagePadding),
      child: ButtonForForm(
        text: 'ПЕРЕЙТИ',
        onPressed: onPressed,
      ),
    );
  }
}
