import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ResetPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  var number = PhoneNumber(isoCode: 'RU');

  final isValidate = false.obs;
  final isLoading = false.obs;
}
