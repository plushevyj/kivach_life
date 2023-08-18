import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import '../../../widgets/local_password/local_password_settings_body.dart';
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
      appBar: AppBar(),
      body: NewLocalPasswordBody(
          newLocalPasswordController: newLocalPasswordController),
    );
  }
}

class NewLocalPasswordBody extends StatelessWidget {
  const NewLocalPasswordBody({
    super.key,
    required this.newLocalPasswordController,
  });

  final NewLocalPasswordController newLocalPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalPasswordSettingBloc, LocalPasswordSettingState>(
      listener: (_, state) {
        if (state is InvalidConfirmedNewLocalPassword) {
          showErrorAlert('Введенные пароли не совпадают');
          newLocalPasswordController.firstPassword.clear();
          newLocalPasswordController.reverse(false);
        } else if (state is GotFirstLocalPassword) {
          newLocalPasswordController.secondPassword.clear();
          newLocalPasswordController.reverse(true);
        } else if (state is SuccessfulPasswordChange) {
          Get.back();
          showSuccessAlert('Локальный пароль изменен');
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
                    return LocalPasswordSettingBody(
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
                  return LocalPasswordSettingBody(
                    controller: newLocalPasswordController.secondPassword,
                    idEnabled: newLocalPasswordController
                        .enableDialButtonsOfConfirmedPassword.value,
                    title: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                  );
                }),
              );
            }
          })(),
        );
      },
    );
  }
}
