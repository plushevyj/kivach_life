import 'package:doctor/models/token_model/token_model.dart';
import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../authentication/repository/token_repository.dart';
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
  final _tokenRepository = const TokenRepository();

  @override
  void onInit() {
    token = Get.parameters['token'] ?? 'unknown';
    print('token = $token');
    super.onInit();
  }

  void register() async {
    try {
      final tokenModel = await _registrationRepository.sendRegistrationData(
        registrationToken: token,
        username: usernameFieldController.text,
        email: emailFieldController.text,
        phone: phoneFieldController.text,
        password: firstPasswordFieldController.text,
      );
    } catch (_) {}
  }
}
