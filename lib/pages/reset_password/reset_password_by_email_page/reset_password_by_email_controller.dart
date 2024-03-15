import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/modules/reset_password_by_email/bloc/reset_password_by_email_bloc.dart';

class ResetPasswordByEmailController extends GetxController {
  final emailErrorMessage = RxnString(null);

  final emailTextFieldController = TextEditingController();

  final isLoading = false.obs;

  void sendEmail(String email) {
    isLoading(true);
    Get.context!
        .read<ResetPasswordByEmailBloc>()
        .add(SendEmailEvent(email: email));
  }
}
