import 'package:doctor/models/profile_preview_model/profile_preview_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            () => Form(
              key: registrationController.keyForm,
              child: Column(
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
                    validator: registrationController.validatorUsername,
                  ),
                  const SizedBox(height: 20),
                  TextFieldForForm(
                    controller: registrationController.emailFieldController,
                    hint: 'Email',
                    validator: registrationController.validatorEmail,
                  ),
                  const SizedBox(height: 20),
                  TextFieldForForm(
                    controller: registrationController.phoneFieldController,
                    hint: 'Телефон',
                    validator: registrationController.validatorPhone,
                  ),
                  const SizedBox(height: 20),
                  TextFieldForForm(
                    controller:
                        registrationController.firstPasswordFieldController,
                    hint: 'Пароль',
                    isPassword: true,
                    validator: registrationController.validatorFirstPassword,
                  ),
                  const SizedBox(height: 20),
                  TextFieldForForm(
                    controller:
                        registrationController.secondPasswordFieldController,
                    hint: 'Подтвердите пароль',
                    isPassword: true,
                    validator: registrationController.validatorSecondPassword,
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
                        width: Get.width * 0.7,
                        child: const Text(
                          'Согласен с условиями пользовательского соглашения '
                          'и политикой обработки персональных данных',
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
