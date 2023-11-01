import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../modules/download_document/repository/download_document_repository.dart';
import '../../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import '../../documents_pages/document_view_page.dart';
import '/models/profile_preview_model/profile_preview_model.dart';
import '/core/themes/light_theme.dart';
import 'registration_controller.dart';
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
    final registrationController = Get.put(RegistrationController(
        registrationToken: registrationToken, userData: profilePreview.user));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заполните форму'),
      ),
      body: Padding(
        padding: pagePadding,
        child: SingleChildScrollView(
          child: Obx(
            () => AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Здравствуйте, ${profilePreview.firstname} ${profilePreview.lastname}.',
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
                    autofillHints: const [AutofillHints.username],
                  ),
                  const SizedBox(height: 20),
                  TextFieldForForm(
                    controller: registrationController.emailFieldController,
                    hint: 'Email',
                    errorText: registrationController.errorTextEmail.value,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: registrationController.formPhoneInputKey,
                    child: IntlPhoneField(
                      controller: registrationController.phoneFieldController,
                      decoration: InputDecoration(
                        labelText: 'Номер телефона',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        errorText: registrationController.errorTextPhone.value,
                      ),
                      onChanged: (number) {
                        registrationController.errorTextPhone.value = null;
                      },
                      onSaved: (number) {
                        registrationController.phone = number?.completeNumber;
                      },
                      initialCountryCode:
                          registrationController.initialCountryCode,
                      disableAutoFillHints: true,
                      autovalidateMode: AutovalidateMode.always,
                      disableLengthCheck: true,
                      languageCode: 'RU',
                      validator: (number) async {
                        if (number?.number == null ||
                            number!.number.isEmpty ||
                            number.number.length >= 8) {
                          return null;
                        }
                        return 'Неверный номер';
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
                  ),
                  const SizedBox(height: 20),
                  PasswordFieldForForm(
                    controller:
                        registrationController.firstPasswordFieldController,
                    hint: 'Пароль',
                    errorText:
                        registrationController.errorTextFirstPassword.value,
                    autofillHints: const [AutofillHints.password],
                  ),
                  const SizedBox(height: 20),
                  PasswordFieldForForm(
                    controller:
                        registrationController.secondPasswordFieldController,
                    hint: 'Подтвердите пароль',
                    errorText:
                        registrationController.errorTextSecondPassword.value,
                    autofillHints: const [AutofillHints.password],
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
                        width: Get.width -
                            pagePadding.left -
                            pagePadding.right -
                            40,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: 'Согласен с '),
                              TextSpan(
                                text: 'условиями пользовательского соглашения',
                                style: const TextStyle(
                                  color: KivachColors.green,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final path =
                                        await DownloadDocumentRepository()
                                            .downloadFile(
                                      url:
                                          '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}/user_agreement.docx',
                                      showProgressAlert: false,
                                    );
                                    if (path != null) {
                                      Get.to(DocumentViewPage(
                                        title: 'Пользовательское соглашение',
                                        path: path,
                                      ));
                                    }
                                  },
                              ),
                              const TextSpan(text: ' и '),
                              TextSpan(
                                text: 'политикой обработки персональных данных',
                                style: const TextStyle(
                                  color: KivachColors.green,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final path =
                                        await DownloadDocumentRepository()
                                            .downloadFile(
                                      url:
                                          '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}/personal_data_politics.docx',
                                      showProgressAlert: false,
                                    );
                                    if (path != null) {
                                      Get.to(DocumentViewPage(
                                        title:
                                            'Политика обработки персональных данных',
                                        path: path,
                                      ));
                                    }
                                  },
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
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
                          fontSize: 13,
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
                      onPressed: () {
                        registrationController.formPhoneInputKey.currentState
                            ?.save();
                        registrationController.register();
                      },
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
