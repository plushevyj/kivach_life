import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/widgets/alerts.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '../../../core/utils/convert_to.dart';
import '../../../models/registration/registration_error_model/registration_error_model.dart';
import '../../authentication/repository/token_repository.dart';
import '../repository/registration_repository.dart';

class RegistrationController extends GetxController {
  RegistrationController({required this.registrationToken});

  final formPhoneInputKey = GlobalKey<FormState>();
  var number = PhoneNumber(isoCode: 'RU');
  final isValidatePhoneNumber = true.obs;
  final isLoading = false.obs;
  final activeRegistrationButton = false.obs;

  final String registrationToken;

  final usernameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final firstPasswordFieldController = TextEditingController();
  final secondPasswordFieldController = TextEditingController();
  final isAgree = false.obs;

  final keyForm = GlobalKey<FormState>();

  var errorTextUsername = RxnString(null),
      errorTextEmail = RxnString(null),
      errorTextPhone = RxnString(null),
      errorTextFirstPassword = RxnString(null),
      errorTextSecondPassword = RxnString(null),
      errorTextAgree = RxnString(null);

  final _registrationRepository = const RegistrationRepository();
  final _tokenRepository = const TokenRepository();

  @override
  void onInit() {
    usernameFieldController.addListener(() => errorTextUsername.value = null);
    emailFieldController.addListener(() => errorTextEmail.value = null);
    phoneFieldController.addListener(() => errorTextPhone.value = null);
    firstPasswordFieldController
        .addListener(() => errorTextFirstPassword.value = null);
    secondPasswordFieldController
        .addListener(() => errorTextSecondPassword.value = null);
    isAgree.listen((_) => errorTextAgree.value = null);
    super.onInit();
  }

  @override
  void dispose() {
    usernameFieldController.dispose();
    emailFieldController.dispose();
    phoneFieldController.dispose();
    firstPasswordFieldController.dispose();
    secondPasswordFieldController.dispose();
    isAgree.close();
    super.dispose();
  }

  void register(BuildContext context) async {
    errorTextUsername(null);
    errorTextEmail(null);
    errorTextPhone(null);
    errorTextFirstPassword(null);
    errorTextSecondPassword(null);
    errorTextAgree(null);
    try {
      isLoading(true);
      final token = await _registrationRepository.sendRegistrationData(
        registrationToken: registrationToken,
        username: usernameFieldController.text,
        email: emailFieldController.text,
        phone: number.phoneNumber ?? '',
        firstPassword: firstPasswordFieldController.text,
        secondPassword: secondPasswordFieldController.text,
        agreeTerms: isAgree.value,
      );
      _tokenRepository.saveToken(token: token);
      BlocProvider.of<AuthenticationBloc>(Get.context!)
          .add(const AuthenticateByToken());
    } on DioException catch (error) {
      if (error.response!.statusCode! >= 500) {
        showErrorAlert('Запрос не выполнен.');
      } else if (error.response!.statusCode! >= 400) {
        final message = await ConvertTo<RegistrationErrorModel>().item(
            error.response?.data['message'], RegistrationErrorModel.fromJson);
        errorTextUsername.value = message.username?.first;
        errorTextEmail.value = message.email?.first;
        errorTextPhone.value = message.phone?.first;
        errorTextFirstPassword.value = message.plainPassword?.first?.first;
        errorTextSecondPassword.value = message.plainPassword?.second?.first;
        errorTextAgree.value = message.agreeTerms?.first;
      }
    } catch (error) {
      showErrorAlert(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
