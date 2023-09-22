import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/profile_preview_model/profile_preview_model.dart';
import '/core/themes/light_theme.dart';
import '../../../modules/registration/controller/registration_controller.dart';
import '../../../widgets/inputs/button_for_form.dart';
import '../../../widgets/inputs/text_field_for_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
    required this.registrationToken,
    required this.profilePreview,
  }) : super(key: key);

  final String registrationToken;
  final ProfilePreview profilePreview;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final registrationController = Get.put(
        RegistrationController(registrationToken: widget.registrationToken));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заполните форму'),
      ),
      body: Padding(
        padding: pagePadding,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Здравствуйте, ${widget.profilePreview.fullname}.',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller: registrationController.usernameFieldController,
                  hint: 'Логин',
                  errorText: registrationController.errorTextUsername.value,
                  errorStyle:
                      registrationController.errorTextUsername.value == null
                          ? const TextStyle(height: 0, fontSize: 0)
                          : null,
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller: registrationController.emailFieldController,
                  hint: 'Email',
                  errorText: registrationController.errorTextEmail.value,
                  // validator: registrationController.validatorEmail,z
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller: registrationController.phoneFieldController,
                  hint: 'Телефон',
                  errorText: registrationController.errorTextPhone.value,
                  // validator: registrationController.validatorPhone,
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller:
                      registrationController.firstPasswordFieldController,
                  hint: 'Пароль',
                  isPassword: true,
                  errorText:
                      registrationController.errorTextFirstPassword.value,
                  // validator: registrationController.validatorFirstPassword,
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller:
                      registrationController.secondPasswordFieldController,
                  hint: 'Подтвердите пароль',
                  isPassword: true,
                  errorText:
                      registrationController.errorTextSecondPassword.value,
                  // validator: registrationController.validatorSecondPassword,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return KivachColors.green;
                        }
                        return null;
                      }),
                      overlayColor: MaterialStateProperty.all(
                        KivachColors.green.withOpacity(0.1),
                      ),
                      side: const BorderSide(
                        color: KivachColors.green,
                        width: 2,
                      ),
                      onChanged: (bool? value) {
                        registrationController.isAgree.value = value!;
                      },
                      value: registrationController.isAgree.value,
                    ),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: const Text(
                        'Согласен с условиями пользовательского соглашения '
                        'и политикой обработки персональных данных.',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                if (registrationController.errorTextAgree.value != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      registrationController.errorTextAgree.value!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Obx(
                  () => ButtonForForm(
                    text: !registrationController.isLoading.value
                        ? 'Зарегистрироваться'
                        : null,
                    child: registrationController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : null,
                    onPressed: () =>
                        registrationController.register(Get.context!),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
