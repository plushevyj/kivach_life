import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../modules/reset_password/bloc/reset_password_bloc.dart';

class ResetPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneFieldController = TextEditingController();
  var number = PhoneNumber(isoCode: 'RU');

  final isValidate = true.obs;
  final isLoading = false.obs;

  @override
  void dispose() {
    phoneFieldController.dispose();
    super.dispose();
  }

  void sendPhoneNumber() {
    isLoading(true);
    formKey.currentState?.save();
    Get.context!
        .read<ResetPasswordBloc>()
        .add(SendNumber(phone: number.phoneNumber ?? ''));
  }
}
