import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../modules/reset_password_by_email/bloc/reset_password_by_email_bloc.dart';
import '../../../widgets/alerts.dart';
import '/core/themes/light_theme.dart';
import '/widgets/inputs/button_for_form.dart';
import '/widgets/inputs/text_field_for_form.dart';
import 'reset_password_by_email_controller.dart';

class ResetPasswordByEmailPage extends StatelessWidget {
  const ResetPasswordByEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPasswordByEmailController =
        Get.put(ResetPasswordByEmailController());
    return BlocListener<ResetPasswordByEmailBloc, ResetPasswordByEmailState>(
      listener: (context, state) {
        if (state is SentEmailState) {
          showSuccessAlert(
              'На вашу почту отправлено письмо. Следуйте инструкции.');
          Navigator.of(context).pop();
          resetPasswordByEmailController.isLoading(false);
        } else if (state is ErrorResetPasswordByEmailState) {
          resetPasswordByEmailController.emailErrorMessage.value =
              state.message;
          resetPasswordByEmailController.isLoading(false);
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
                'Восстановление пароля',
                style: TextStyle(
                  fontSize: 18,
                  color: KivachColors.green,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => TextFieldForForm(
                  keyboardType: TextInputType.emailAddress,
                  controller:
                      resetPasswordByEmailController.emailTextFieldController,
                  hint: 'E-mail',
                  errorText:
                      resetPasswordByEmailController.emailErrorMessage.value,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => ButtonForForm(
                  onPressed: !resetPasswordByEmailController.isLoading.value
                      ? () => resetPasswordByEmailController.sendEmail(
                          resetPasswordByEmailController
                              .emailTextFieldController.text)
                      : null,
                  text: !resetPasswordByEmailController.isLoading.value
                      ? 'Получить письмо для подтверждения'
                      : null,
                  child: resetPasswordByEmailController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.offNamed('/reset/sms'),
                child: const Text('Восстановить пароль по номеру телефона'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
