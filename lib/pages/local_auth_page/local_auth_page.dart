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
                  Obx(() {
                    return SizedBox(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int index = 1;
                              index <=
                                  PasswordController.maxLengthLocalPassword;
                              index++)
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: passwordController
                                            .localPasswordLength.value >=
                                        index
                                    ? Colors.green
                                    : const Color(0xFFD7D7D7),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 100),
                  Obx(
                    () {
                      return GridView.count(
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 3,
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...[for (int i = 1; i <= 9; i++) i]
                              .map(
                                (value) => IconButton(
                                  onPressed:
                                      passwordController.enableDialButton.value
                                          ? () => passwordController
                                              .enterNumberToPassword(value)
                                          : null,
                                  icon: Text(
                                    value.toString(),
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ),
                              )
                              .toList(),
                          IconButton(
                            onPressed: passwordController.enableDialButton.value
                                ? () => SystemNavigator.pop()
                                : null,
                            icon: const Text(
                              'ВЫЙТИ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: passwordController.enableDialButton.value
                                ? () =>
                                    passwordController.enterNumberToPassword(0)
                                : null,
                            icon: const Text(
                              '0',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          passwordController.showBiometricButton.value
                              ? IconButton(
                                  onPressed: passwordController
                                          .enableDialButton.value
                                      ? () => Get.context!
                                          .read<LocalAuthenticationBloc>()
                                          .add(
                                              const LogInLocallyUsingBiometrics())
                                      : null,
                                  icon: const Icon(Icons.fingerprint, size: 30),
                                )
                              : IconButton(
                                  onPressed:
                                      passwordController.enableDialButton.value
                                          ? () => passwordController
                                              .deleteNumberFromPassword()
                                          : null,
                                  icon: const Icon(Icons.backspace),
                                ),
                        ],
                      );
                    },
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
