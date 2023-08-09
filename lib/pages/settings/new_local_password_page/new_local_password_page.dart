import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import '/core/constants.dart';
import '/widgets/digital_input/digital_input_widget.dart';
import '/widgets/digital_input/digital_field.dart';
import '/pages/settings/new_local_password_page/new_password_controller.dart';
import 'package:animations/animations.dart';
import '/widgets/alerts.dart';

class NewLocalPasswordPage extends StatelessWidget {
  const NewLocalPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newLocalPasswordController = Get.put(NewLocalPasswordController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      ),
      body: BlocConsumer<LocalPasswordSettingBloc, LocalPasswordSettingState>(
        listener: (_, state) {
          newLocalPasswordController
            ..firstPassword.clear()
            ..secondPassword.clear();
          if (state is InvalidConfirmedNewLocalPassword) {
            showErrorAlert('Введенные пароли не совпадают');
            newLocalPasswordController.reverse(false);
          } else if (state is GotFirstLocalPassword) {
            newLocalPasswordController.reverse(true);
          } else if (state is SuccessfulPasswordChange) {
            Get.back();
            showSuccessAlert('Локальный пароль изменен');
          } else if (state is InvalidConfirmedNewLocalPassword) {
            showErrorAlert('Неверный пароль');
          } else if (state is ErrorNewLocalPasswordState) {
            Get.back();
            showErrorAlert(state.error);
          }
        },
        builder: (context, state) {
          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 500),
            reverse: !newLocalPasswordController.reverse.value,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: (() {
              if (state is ProofedOfIdentity ||
                  state is InvalidConfirmedNewLocalPassword) {
                return Scaffold(
                  key: UniqueKey(),
                  body: Obx(
                    () {
                      return _LocalPasswordSettingBody(
                        controller: newLocalPasswordController.firstPassword,
                        idEnabled: newLocalPasswordController
                            .enableDialButtonsOfPassword.value,
                        title: 'ПРИДУМАЙТЕ ПАРОЛЬ',
                      );
                    },
                  ),
                );
              } else if (state is GotFirstLocalPassword) {
                return Scaffold(
                  key: UniqueKey(),
                  body: Obx(() {
                    return _LocalPasswordSettingBody(
                      controller: newLocalPasswordController.secondPassword,
                      idEnabled: newLocalPasswordController
                          .enableDialButtonsOfConfirmedPassword.value,
                      title: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                    );
                  }),
                );
              } else {
                return Scaffold(
                  key: UniqueKey(),
                );
              }
            })(),
          );
        },
      ),
    );
  }
}

class _LocalPasswordSettingBody extends StatelessWidget {
  const _LocalPasswordSettingBody({
    Key? key,
    required this.controller,
    required this.idEnabled,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final bool idEnabled;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 150,
            child: DigitalField(
              controller: controller,
              maxLength: maxLengthLocalPassword,
            ),
          ),
          const SizedBox(height: 150),
          DigitalInput(
            controller: controller,
            maxLength: maxLengthLocalPassword,
            isEnabled: idEnabled,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
