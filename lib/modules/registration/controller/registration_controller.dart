import 'package:dio/dio.dart';
import 'package:doctor/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

import '/widgets/alerts.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '../../../core/utils/convert_to.dart';
import '../../../models/registration/registration_error_model/registration_error_model.dart';
import '../../authentication/repository/token_repository.dart';
import '../repository/registration_repository.dart';

class RegistrationController extends GetxController {
  RegistrationController({required this.registrationToken, this.userData});

  final String registrationToken;
  final User? userData;

  final formPhoneInputKey = GlobalKey<FormState>();
  var phone = '';
  late final String initialCountryCode;
  final isValidatePhoneNumber = true.obs;
  final isLoading = false.obs;
  final activeRegistrationButton = false.obs;

  late final TextEditingController usernameFieldController;
  late final TextEditingController emailFieldController;
  late final TextEditingController phoneFieldController;
  final firstPasswordFieldController = TextEditingController();
  final secondPasswordFieldController = TextEditingController();
  final isAgree = false.obs;

  final keyForm = GlobalKey<FormState>();

  var errorTextUsername = RxnString(null);
  var errorTextEmail = RxnString(null);
  var errorTextPhone = RxnString(null);
  var errorTextFirstPassword = RxnString(null);
  var errorTextSecondPassword = RxnString(null);
  var errorTextAgree = RxnString(null);

  final _registrationRepository = const RegistrationRepository();
  final _tokenRepository = const TokenRepository();

  @override
  void onInit() {
    usernameFieldController = TextEditingController(text: userData?.username)
      ..addListener(() => errorTextUsername.value = null);
    emailFieldController = TextEditingController(text: userData?.email)
      ..addListener(() => errorTextEmail.value = null);
    final fullPhoneData = userData?.phone != null
        ? separatePhoneAndDialCode(userData!.phone!)
        : null;
    initialCountryCode = fullPhoneData?.$3.code ?? 'RU';
    phoneFieldController = TextEditingController(text: fullPhoneData?.$2)
      ..addListener(() => errorTextPhone.value = null);
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

  //(dialCode, basePartOfPhoneNumber, Country)
  (String, String, Country)? separatePhoneAndDialCode(String fullPhone) {
    fullPhone = fullPhone.substring(1);
    Country? foundedCountry;
    for (var country in countries) {
      String dialCode = country.dialCode.toString();
      if (fullPhone.startsWith(dialCode)) {
        foundedCountry = country;
      }
    }
    if (foundedCountry != null) {
      var dialCode = fullPhone.substring(
        0,
        foundedCountry.dialCode.length,
      );
      var basePart = fullPhone.substring(
        foundedCountry.dialCode.length,
      );
      return (dialCode, basePart, foundedCountry);
    }
    return null;
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
        phone: phone,
        firstPassword: firstPasswordFieldController.text,
        secondPassword: secondPasswordFieldController.text,
        agreeTerms: isAgree.value,
      );
      _tokenRepository.saveToken(token: token);
      BlocProvider.of<AuthenticationBloc>(Get.context!)
          .add(const AuthenticateByToken());
    } on DioException catch (error) {
      print('error = $error');
      print(error.message);
      print(error.response);
      if (error.response!.statusCode! == 400) {
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
      print(error);
      showErrorAlert(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
