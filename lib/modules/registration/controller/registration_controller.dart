import 'dart:async';

import 'package:dio/dio.dart';
import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/utils/convert_to.dart';
import '../../../models/registration/registration_error_model/registration_error_model.dart';
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

  final keyForm = GlobalKey<FormState>();

  FormFieldValidator<String?>? validatorUsername,
      validatorEmail,
      validatorPhone,
      validatorFirstPassword,
      validatorSecondPassword,
      validatorAgree;

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
      print('usernameFieldController.text = ${usernameFieldController.text}');
      _tokenRepository.saveToken(token: token);
      print(await _tokenRepository.getRefreshToken());
      print(await _tokenRepository.getAccessToken());
      BlocProvider.of<AuthenticationBloc>(Get.context!)
          .add(const AuthenticateByToken());
    } on DioException catch (error) {
      if (error.response!.statusCode! >= 500) {
        showErrorAlert('Запрос не выполнен.');
      } else if (error.response!.statusCode! >= 400) {
        final message = await ConvertTo<RegistrationErrorModel>().item(
            error.response?.data['message'], RegistrationErrorModel.fromJson);
        print(message);
        validatorUsername = (_) => message.username?.first;
        validatorEmail = (_) => message.email?.first;
        validatorPhone = (_) => message.phone?.first;
        validatorFirstPassword = (_) => message.plainPassword?.first?.first;
        validatorSecondPassword = (_) => message.plainPassword?.second?.first;
        validatorAgree = (_) => message.agreeTerms?.first;
      }
    } catch (error) {
      showErrorAlert(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
