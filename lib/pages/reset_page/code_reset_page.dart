import 'dart:async';

import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:doctor/modules/reset_password/bloc/reset_password_bloc.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:doctor/widgets/inputs/button_for_form.dart';
import 'package:doctor/widgets/inputs/text_field_for_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/themes/light_theme.dart';
import 'code_reset_controller.dart';

class SMSCodePage extends StatelessWidget {
  const SMSCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final codeResetController = Get.put(CodeResetController());
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        codeResetController.isLoading(false);
        if (state is SuccessCode) {
          Get.context!
              .read<AuthenticationBloc>()
              .add(const AuthenticateByToken());
        } else if (state is SuccessNumber) {
          codeResetController.startTimer();
        } else if (state is ErrorResetPasswordState) {
          showErrorAlert(state.error);
          Get.context!
              .read<ResetPasswordBloc>()
              .add(const GetReadyToSendCode());
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Подтверждение номера телефона',
                style: TextStyle(
                  fontSize: 18,
                  color: KivachColors.green,
                ),
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                  controller: codeResetController.textController,
                  hint: 'Введите код из СМС'),
              const SizedBox(height: 20),
              Obx(
                () {
                  print(codeResetController.timerMessage.value);
                  return codeResetController.timerMessage.value != null
                      ? Text(
                          'Отправить код повторно через ${codeResetController.timerMessage.value!}.')
                      : TextButton(
                          onPressed: () {
                            Get.context!
                                .read<ResetPasswordBloc>()
                                .add(const SendNumber());
                          },
                          child: const Text(
                            'Отправить код ещё раз',
                            style: TextStyle(
                              color: KivachColors.green,
                            ),
                          ),
                        );
                },
              ),
              const SizedBox(height: 20),
              Obx(
                () => ButtonForForm(
                  onPressed: !codeResetController.isLoading.value
                      ? () {
                          codeResetController.isLoading(true);
                          if (codeResetController
                              .textController.text.isNotEmpty) {
                            Get.context!.read<ResetPasswordBloc>().add(SendCode(
                                code: codeResetController.textController.text));
                          }
                        }
                      : null,
                  text:
                      !codeResetController.isLoading.value ? 'Отправить' : null,
                  child: codeResetController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
