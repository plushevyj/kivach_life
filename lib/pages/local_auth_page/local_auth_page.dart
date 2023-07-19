import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'local_password_controller.dart';
import '/widgets/digital_input/digital_field.dart';
import '/widgets/digital_input/digital_input_widget.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(LocalPasswordController());
    return Scaffold(
      body: BlocConsumer<LocalAuthenticationBloc, LocalAuthenticationState>(
        listener: (_, state) {
          if (state is LocallyNotAuthenticated) {
            passwordController.password.clear();
            if (passwordController.firstRenderer.value && state.localAuthenticationSetting.$2) {
              Get.context!
                  .read<LocalAuthenticationBloc>()
                  .add(const LogInLocallyUsingBiometrics());
              passwordController.firstRenderer(false);
            }
          }
        },
        builder: (_, state) {
          if (state is LocallyAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocallyNotAuthenticated) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFD7D7D7),
                    child: Icon(Icons.person, size: 30, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 150,
                    child: DigitalField(
                      controller: passwordController.password,
                      maxLength: maxLengthLocalPassword,
                    ),
                  ),
                  const SizedBox(height: 150),
                  Obx(
                    () => DigitalInput(
                      controller: passwordController.password,
                      maxLength: maxLengthLocalPassword,
                      isEnabled: passwordController.enableDialButtons.value,
                      leftWidget: const Text('ВЫЙТИ'),
                      leftWidgetAction: SystemNavigator.pop,
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
