import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '/core/themes/light_theme.dart';
import '/widgets/local_password/digital_field.dart';
import '/widgets/local_password/digital_input_widget.dart';
import '../controller/identity_proof_controller.dart';
import '/core/constants.dart';

Future<bool> identityProof({String? password}) async {
  final identityProofController = Get.put(IdentityProofController());
  var localAuthSettings = await identityProofController
      .localAuthenticationRepository
      .checkLocalAuthenticationSettings();
  if (!localAuthSettings.$1) {
    return true;
  }
  if (password != null &&
      await identityProofController.checkPassword(password)) {
    return true;
  }
  final canAuthenticateByBiometric = await identityProofController
      .localAuthenticationRepository
      .canAuthenticateByBiometric();
  if (!canAuthenticateByBiometric && localAuthSettings.$2) {
    identityProofController.localAuthenticationRepository
        .deleteBiometricSetting();
    localAuthSettings = (localAuthSettings.$1, false);
  }
  await Get.bottomSheet(
    Container(
      height: Get.height - kToolbarHeight - 20,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
          ),
          GetX(
            init: identityProofController,
            global: false,
            initState: (state) {},
            dispose: (state) {
              state.controller?.dispose();
            },
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ВВЕДИТЕ КОД-ПАРОЛЬ',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 150,
                    child: DigitalField(
                      controller: controller.inputController,
                      maxLength: maxLengthLocalPassword,
                    ),
                  ),
                  SizedBox(height: Get.height * (isSmallScreen ? 0.1 : 0.15)),
                  DigitalInput(
                    controller: controller.inputController,
                    maxLength: maxLengthLocalPassword,
                    isEnabled: controller.enableDialButtons.value,
                    leftWidget: localAuthSettings.$2
                        ? const Icon(Icons.fingerprint)
                        : null,
                    leftWidgetAction: localAuthSettings.$2
                        ? () => controller.biometricAction()
                        : null,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ],
      ),
    ),
    barrierColor: Colors.black.withOpacity(0.5),
    isDismissible: true,
    backgroundColor: Colors.white,
    elevation: 20,
    isScrollControlled: true,
  );
  return identityProofController.result.value;
}
