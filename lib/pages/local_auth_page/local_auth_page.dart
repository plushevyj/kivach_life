import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../modules/account/controllers/avatar_controller.dart';
import '../../widgets/local_password/digital_field.dart';
import '../../widgets/local_password/digital_input_widget.dart';
import '../../widgets/modal/logout_dialog.dart';
import '/core/themes/light_theme.dart';
import '../../core/utils/constants.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'local_password_controller.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({
    Key? key,
  }) : super(key: key);

  static const route = '/local_auth';

  @override
  Widget build(BuildContext context) {
    Get.context!
        .read<LocalAuthenticationBloc>()
        .add(const LocallyAuthStarted());
    final localPasswordPageController = Get.put(LocalPasswordPageController());
    final avatarController = Get.put(AvatarController());
    return Scaffold(
      body: BlocConsumer<LocalAuthenticationBloc, LocalAuthenticationState>(
        listener: (_, state) {
          if (state is LocallyAuthenticated) {
            Get.offNamed('/home');
          } else if (state is LocallyNotAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              FlutterNativeSplash.remove();
              if (localPasswordPageController.firstRenderer.value &&
                  state.localAuthenticationSetting.$2) {
                Get.context!
                    .read<LocalAuthenticationBloc>()
                    .add(const LogInLocallyUsingBiometrics());
                localPasswordPageController.firstRenderer(false);
              }
            });
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Column(
                    children: [
                      Obx(
                        () => Skeletonizer(
                          enabled: avatarController.avatarLoading.value,
                          effect:
                              ShimmerEffect(baseColor: Colors.grey.shade300),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: const Color(0xFFD7D7D7),
                            foregroundImage: avatarController.image?.image,
                            child: avatarController.image == null
                                ? const Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Colors.grey,
                                  )
                                : null,
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
                    ],
                  ),
                  Column(
                    children: [
                      Obx(
                        () => DigitalInput(
                          controller: localPasswordPageController.password,
                          maxLength: maxLengthLocalPassword,
                          isEnabled: localPasswordPageController
                              .enableDialButtons.value,
                          leftWidget: Text(
                            'ВЫЙТИ',
                            style:
                                TextStyle(fontSize: isSmallScreen ? 12 : null),
                          ),
                          leftWidgetAction: () =>
                              showLogOutAlert(isNative: true),
                          rightWidget: state.localAuthenticationSetting.$2
                              ? const Icon(Icons.fingerprint)
                              : null,
                          rightWidgetAction: state.localAuthenticationSetting.$2
                              ? () => Get.context!
                                  .read<LocalAuthenticationBloc>()
                                  .add(const LogInLocallyUsingBiometrics())
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: KivachColors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
