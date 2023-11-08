import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../code_reset_page/code_reset_page.dart';
import '/modules/reset_password/bloc/reset_password_bloc.dart';
import '/widgets/inputs/button_for_form.dart';
import '../../../core/themes/light_theme.dart';
import '../../../widgets/alerts.dart';
import 'reset_controller.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPageController = Get.put(ResetPageController());
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        resetPageController.isLoading(false);
        if (state is SuccessNumber) {
          () => Get.to(SMSCodePage(remainingTime: state.remainingTime));
        } else if (state is ErrorResetPasswordState) {
          showErrorAlert(state.error);
          resetPageController.isLoading(false);
          Get.context!
              .read<ResetPasswordBloc>()
              .add(const GetReadyToSendData());
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
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Номер телефона',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (_) {
                  resetPageController.phoneErrorMessage = null;
                },
                initialCountryCode: 'RU',
                invalidNumberMessage: 'Неверный номер',
                disableAutoFillHints: true,
                autovalidateMode: AutovalidateMode.always,
                disableLengthCheck: true,
                languageCode: 'RU',
                validator: (number) async {
                  resetPageController.phone = number!.completeNumber;
                  if (number.number.length < 10) {
                    resetPageController.isValidate(false);
                    return 'Неверный номер';
                  }
                  resetPageController.isValidate(true);
                  return resetPageController.phoneErrorMessage;
                },
                pickerDialogStyle: PickerDialogStyle(
                  backgroundColor: Colors.white,
                  countryNameStyle:
                      const TextStyle(fontWeight: FontWeight.normal),
                  searchFieldInputDecoration: null,
                  searchFieldPadding: null,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => ButtonForForm(
                  onPressed: !resetPageController.isLoading.value &&
                          resetPageController.isValidate.value
                      ? () => resetPageController
                          .sendPhoneNumber(resetPageController.phone)
                      : null,
                  text: !resetPageController.isLoading.value
                      ? 'Получить код подтверждения'
                      : null,
                  child: resetPageController.isLoading.value
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
