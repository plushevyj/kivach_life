import 'dart:io' show Platform;

import 'package:doctor/modules/account/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/local_password/digital_field.dart';
import '../../widgets/local_password/digital_input_widget.dart';
import '/core/themes/light_theme.dart';
import '/core/constants.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'local_password_controller.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.context!
        .read<LocalAuthenticationBloc>()
        .add(const LocallyAuthStarted());
    final localPasswordPageController = Get.put(LocalPasswordPageController());
    return Scaffold(
      body: BlocConsumer<LocalAuthenticationBloc, LocalAuthenticationState>(
        listener: (_, state) {
          if (state is LocallyAuthenticated) {
            Get.offNamed('/home');
          } else if (state is LocallyNotAuthenticated) {
            if (localPasswordPageController.firstRenderer.value &&
                state.localAuthenticationSetting.$2) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.context!
                    .read<LocalAuthenticationBloc>()
                    .add(const LogInLocallyUsingBiometrics());
                localPasswordPageController.firstRenderer(false);
              });
            }
            localPasswordPageController.password.clear();
          }
        },
        builder: (_, state) {
          if (state is LocallyAuthenticated) {
            return const Center(
              child: CircularProgressIndicator(
                color: KivachColors.green,
              ),
            );
          } else if (state is LocallyNotAuthenticated) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Skeletonizer(
                      enabled: localPasswordPageController.avatarLoading.value,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFFD7D7D7),
                        foregroundImage:
                            localPasswordPageController.image?.image,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 150,
                    child: DigitalField(
                      controller: localPasswordPageController.password,
                      maxLength: maxLengthLocalPassword,
                    ),
                  ),
                  const SizedBox(height: 150),
                  Obx(
                    () => DigitalInput(
                      controller: localPasswordPageController.password,
                      maxLength: maxLengthLocalPassword,
                      isEnabled:
                          localPasswordPageController.enableDialButtons.value,
                      leftWidget: state.localAuthenticationSetting.$2
                          ? Icon(
                              Platform.isIOS ? Icons.face : Icons.fingerprint)
                          : null,
                      leftWidgetAction: state.localAuthenticationSetting.$2
                          ? () => Get.context!
                              .read<LocalAuthenticationBloc>()
                              .add(const LogInLocallyUsingBiometrics())
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: KivachColors.green,
            ));
          }
        },
      ),
    );
  }
}
