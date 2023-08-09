import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/identity_proof_controller.dart';
import '/core/constants.dart';
import '/widgets/digital_input/digital_field.dart';
import '/widgets/digital_input/digital_input_widget.dart';

Future<bool> identityProof() async {
  final identityProofController = Get.put(IdentityProofController());
  final localAuthSettings = await identityProofController
      .localAuthenticationRepository
      .checkLocalAuthenticationSettings();
  if (!localAuthSettings.$1) {
    return true;
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
                  const Text(
                    'ВВЕДИТЕ КОД-ПАРОЛЬ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 150,
                    child: DigitalField(
                      controller: controller.password,
                      maxLength: maxLengthLocalPassword,
                    ),
                  ),
                  const SizedBox(height: 150),
                  DigitalInput(
                    controller: controller.password,
                    maxLength: maxLengthLocalPassword,
                    isEnabled: controller.enableDialButtons.value,
                    leftWidget: localAuthSettings.$2
                        ? Icon(Platform.isIOS ? Icons.face : Icons.fingerprint)
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
