import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/alerts.dart';
import '../../../core/constants.dart';
import '../../local_authentication/repository/local_authentication_repository.dart';

class IdentityProofController extends GetxController {
  IdentityProofController({this.password});

  final String? password;

  final localAuthenticationRepository = const LocalAuthenticationRepository();
  final inputController = TextEditingController();
  final enableDialButtons = true.obs;
  var result = false.obs;

  @override
  void onInit() async {
    result.listen((value) {
      if (value) {
        Navigator.pop(Get.context!);
      }
    });
    inputController.addListener(() {
      enableDialButtons(inputController.text.length < maxLengthLocalPassword);
      if (inputController.text.length == maxLengthLocalPassword) {
        Timer(const Duration(milliseconds: 500), () async {
          final enteredPasswordHash =
              sha256.convert(utf8.encode(inputController.text)).toString();
          if (await checkPassword(enteredPasswordHash)) {
            result(true);
          } else {
            showErrorAlert('Неверный пароль');
          }
          inputController.clear();
        });
      }
    });
    if (await checkPassword(password)) {
      result(true);
    }
    super.onInit();
  }

  Future<bool> checkPassword(enteredPassword) async {
    final currentPasswordHash =
        (await localAuthenticationRepository.getLocalPasswordSetting())?.hash;
    return enteredPassword == currentPasswordHash;
  }

  void biometricAction() async {
    try {
      result(await localAuthenticationRepository.authenticateByBiometric());
    } catch (_) {}
  }

  @override
  void dispose() {
    result.close();
    inputController.dispose();
    super.dispose();
  }
}
