import 'package:doctor/models/profile_preview_model/profile_preview_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/themes/light_theme.dart';
import '../../../modules/registration/controller/registration_controller.dart';
import '../../../widgets/inputs/button_for_form.dart';
import '../../../widgets/inputs/text_field_for_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key? key,
    required this.registrationToken,
    required this.profilePreview,
  }) : super(key: key);

  final String registrationToken;
  final ProfilePreview profilePreview;

  @override
  Widget build(BuildContext context) {
    final registrationController = Get.put(RegistrationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заполните форму'),
      ),
      body: Padding(
        padding: pagePadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Здравствуйте, ${profilePreview.fullname}.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                controller: registrationController.usernameFieldController,
                hint: 'Логин',
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                controller: registrationController.emailFieldController,
                hint: 'Email',
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                controller: registrationController.phoneFieldController,
                hint: 'Телефон',
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                controller: registrationController.firstPasswordFieldController,
                hint: 'Пароль',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              TextFieldForForm(
                controller:
                    registrationController.secondPasswordFieldController,
                hint: 'Подтвердите пароль',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
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
              ),
              const SizedBox(height: 20),
              ButtonForForm(
                text: 'Зарегистрироваться',
                onPressed: () => registrationController.register(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
