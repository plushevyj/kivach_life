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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Skeletonizer(
                      enabled: avatarController.avatarLoading.value,
                      child: CircleAvatar(
                        radius: isSmallScreen ? 36 : 40,
                        backgroundColor: const Color(0xFFD7D7D7),
                        foregroundImage: avatarController.image?.image,
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
                  SizedBox(height: Get.height * (isSmallScreen ? 0.1 : 0.15)),
                  Obx(
                    () => DigitalInput(
                      controller: localPasswordPageController.password,
                      maxLength: maxLengthLocalPassword,
                      isEnabled:
                          localPasswordPageController.enableDialButtons.value,
                      leftWidget: Text(
                        'ВЫЙТИ',
                        style: TextStyle(fontSize: isSmallScreen ? 12 : null),
                      ),
                      leftWidgetAction: () => showLogOutAlert(),
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
