import 'package:doctor/widgets/digital_input/digital_field.dart';
import 'package:doctor/widgets/digital_input/digital_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'password_controller.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(PasswordController());
    Get.context!
        .read<LocalAuthenticationBloc>()
        .add(const LogInLocallyUsingBiometrics());
    return Scaffold(
      body: BlocBuilder<LocalAuthenticationBloc, LocalAuthenticationState>(
        builder: (_, state) {
          if (state is LocallyAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          } else {
            passwordController.password.clear();
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
                      maxLength: PasswordController.maxLengthLocalPassword,
                    ),
                  ),
                  const SizedBox(height: 150),
                  Obx(
                    () => DigitalInput(
                      controller: passwordController.password,
                      maxLength: PasswordController.maxLengthLocalPassword,
                      isEnabled: passwordController.enableDialButtons.value,
                      leftWidget: const Text('ВЫЙТИ'),
                      leftWidgetAction: SystemNavigator.pop,
                      rightWidget: const Icon(Icons.fingerprint),
                      rightWidgetAction: () => Get.context!
                          .read<LocalAuthenticationBloc>()
                          .add(const LogInLocallyUsingBiometrics()),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
