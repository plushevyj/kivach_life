import 'package:dio/dio.dart';
import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../authentication/repository/token_repository.dart';
import '../repository/registration_repository.dart';

class RegistrationController extends GetxController {
  RegistrationController({required this.registrationToken});

  final isLoading = false.obs;

  final String registrationToken;

  final usernameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final firstPasswordFieldController = TextEditingController();
  final secondPasswordFieldController = TextEditingController();
  final isAgree = false.obs;

  final _registrationRepository = const RegistrationRepository();
  final _tokenRepository = const TokenRepository();

  void register(BuildContext context) async {
    try {
      isLoading(true);
      final token = await _registrationRepository.sendRegistrationData(
        registrationToken: registrationToken,
        username: usernameFieldController.text,
        email: emailFieldController.text,
        phone: phoneFieldController.text,
        password: firstPasswordFieldController.text,
        agreeTerms: isAgree.value,
      );
      _tokenRepository.saveToken(token: token);

      BlocProvider.of<AuthenticationBloc>(Get.context!)
          .add(const AuthenticateByToken());
    } on DioException catch (error) {
      showErrorAlert(error.response?.data['message']);
    } catch (error) {
      showErrorAlert(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
