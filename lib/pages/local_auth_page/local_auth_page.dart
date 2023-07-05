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
            return const CircularProgressIndicator();
          } else {
            passwordController.password.clear();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: passwordController.password,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      letterSpacing: 15,
                    ),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    enabled: false,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                  ),
                  Obx(
                    () => Column(
                      children: [
                        ...[
                          [1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 9],
                        ]
                            .map(
                              (list) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: list
                                    .map(
                                      (value) => IconButton(
                                        onPressed: passwordController
                                                .enableDialButton.value
                                            ? () => passwordController
                                                .enterNumberToPassword(value)
                                            : null,
                                        icon: Text(
                                          '$value',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                            .toList(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed:
                                  passwordController.enableDialButton.value
                                      ? () {
                                          Get.context!
                                              .read<LocalAuthenticationBloc>()
                                              .add(
                                                  const LogInLocallyUsingBiometrics());
                                        }
                                      : null,
                              icon: const Icon(
                                Icons.fingerprint,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  passwordController.enableDialButton.value
                                      ? () => passwordController
                                          .enterNumberToPassword(0)
                                      : null,
                              icon: const Text('0',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            IconButton(
                              onPressed:
                                  passwordController.enableDialButton.value
                                      ? () => passwordController
                                          .deleteNumberFromPassword()
                                      : null,
                              icon: const Icon(
                                Icons.backspace,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
