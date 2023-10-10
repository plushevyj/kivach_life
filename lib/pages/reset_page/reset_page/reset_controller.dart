import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../modules/reset_password/bloc/reset_password_bloc.dart';

class ResetPageController extends GetxController {
  String? phoneErrorMessage;
  String phone = '';

  final isValidate = true.obs;
  final isLoading = false.obs;

  void sendPhoneNumber(String phone) {
    isLoading(true);
    Get.context!.read<ResetPasswordBloc>().add(SendNumber(phone: phone));
  }
}
