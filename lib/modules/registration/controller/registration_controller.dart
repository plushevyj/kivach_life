import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/registration_repository.dart';

class RegistrationController extends GetxController {
  final usernameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final firstPasswordFieldController = TextEditingController();
  final secondPasswordFieldController = TextEditingController();
  final isAgree = false.obs;

  late String token;

  final _registrationRepository = const RegistrationRepository();

  @override
  void onInit() {
    token = Get.parameters['_token'] ?? 'unknown';
    print('token = $token');
    super.onInit();
  }

  void register() async {
    _registrationRepository.sendUserData(
      token: token,
      username: usernameFieldController.text,
      email: emailFieldController.text,
      phone: phoneFieldController.text,
      password: firstPasswordFieldController.text,
    );
  }
}
