import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/alerts.dart';
import '../../../core/constants.dart';
import '../../local_authentication/repository/local_authentication_repository.dart';

class IdentityProofController extends GetxController {
  final localAuthenticationRepository = const LocalAuthenticationRepository();
  final password = TextEditingController();
  final enableDialButtons = true.obs;
  var result = false.obs;

  @override
  void onInit() async {
    result.listen((value) {
      if (value) {
        Navigator.pop(Get.context!);
      }
    });
    password.addListener(() {
      enableDialButtons(password.text.length < maxLengthLocalPassword);
      if (password.text.length == maxLengthLocalPassword) {
        Timer(const Duration(milliseconds: 500), () async {
          final enteredPasswordHash =
              sha256.convert(utf8.encode(password.text)).toString();
          final currentPasswordHash =
              (await localAuthenticationRepository.getLocalPasswordSetting())
                  ?.hash;
          if (enteredPasswordHash == currentPasswordHash) {
            result(true);
          } else {
            showErrorAlert('Неверный пароль');
          }
          password.clear();
        });
      }
    });
    super.onInit();
  }

  void biometricAction() async {
    try {
      result(await localAuthenticationRepository.authenticateByBiometric());
    } catch (_) {}
  }

  @override
  void dispose() {
    result.close();
    password.dispose();
    super.dispose();
  }
}
