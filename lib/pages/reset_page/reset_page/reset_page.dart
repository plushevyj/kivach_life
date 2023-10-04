import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
          Get.offNamed('/reset/sms');
        } else if (state is ErrorResetPasswordState) {
          showErrorAlert(state.error);
          Get.context!
              .read<ResetPasswordBloc>()
              .add(const ResetPasswordEventInitial());
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: pagePadding,
          child: Form(
            key: resetPageController.formKey,
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
                InternationalPhoneNumberInput(
                  locale: 'RU',
                  onInputChanged: (_) {
                    final cursorPosition =
                        resetPageController.phoneFieldController.selection;
                    resetPageController.phoneFieldController.text =
                        resetPageController.phoneFieldController.text
                            .replaceAll(RegExp(r'[a-zA-Zа-яА-ЯёЁ.,]'), '');
                    resetPageController.phoneFieldController.selection =
                        cursorPosition;
                  },
                  spaceBetweenSelectorAndTextField: 0,
                  selectorButtonOnErrorPadding: 0,
                  onInputValidated: (value) {
                    resetPageController.isValidate(value);
                  },
                  onSaved: (number) {
                    resetPageController.number = number;
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  searchBoxDecoration: const InputDecoration(
                    labelText: 'Поиск по наименованиям стран и кодов регионов',
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.always,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: resetPageController.number,
                  textFieldController: resetPageController.phoneFieldController,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  validator: (_) {
                    if (!resetPageController.isValidate.value) {
                      return 'Неверный номер';
                    }
                    return null;
                  },
                  inputDecoration: const InputDecoration(
                    labelText: 'Номер телефона',
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => ButtonForForm(
                    onPressed: !resetPageController.isLoading.value &&
                            resetPageController.isValidate.value &&
                            resetPageController
                                .phoneFieldController.text.isNotEmpty
                        ? () => resetPageController.sendPhoneNumber()
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
      ),
    );
  }
}
