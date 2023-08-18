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
          if (await checkPassword(inputController.text)) {
            result(true);
          } else {
            showErrorAlert('Неверный пароль');
          }
          inputController.clear();
        });
      }
    });
    super.onInit();
  }

  Future<bool> checkPassword(String enteredPassword) async {
    final enteredPasswordHash =
        sha256.convert(utf8.encode(enteredPassword)).toString();
    final currentPasswordHash =
        (await localAuthenticationRepository.getLocalPasswordSetting())?.hash;
    return enteredPasswordHash == currentPasswordHash;
  }

  void biometricAction() async {
    try {
      result(await localAuthenticationRepository.authenticateByBiometric());
    } catch (_) {}
  }

  @override
  void dispose() {
    result.close();
    // enableDialButtons.close();
    inputController.dispose();
    super.dispose();
  }
}
