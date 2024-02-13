import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../../../modules/authentication/bloc/authentication_bloc.dart';
import '../../../modules/authentication/repository/token_repository.dart';
import '../../../modules/reset_password_by_email/repository/reset_password_by_email_repository.dart';
import '../registration/registration_page/registration_page.dart';
import '/widgets/alerts.dart';
import '../../../modules/registration/repository/registration_repository.dart';

class QRScannerPageController extends GetxController {
  final result = Rxn<Barcode>();
  final flashlight = false.obs;
  QRViewController? qrViewController;
  final _registrationRepository = const RegistrationRepository();
  final _resetPasswordByEmailRepository = ResetPasswordByEmailRepository();
  final _tokenRepository = const TokenRepository();
  final errorAlertAllow = true.obs;

  @override
  void onInit() {
    errorAlertAllow.listen((value) {
      if (!value) {
        Future.delayed(
            const Duration(seconds: 5), () async => errorAlertAllow(true));
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    result.close();
    qrViewController?.dispose();
    flashlight.close();
    errorAlertAllow.close();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) async {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) async {
      try {
        if (errorAlertAllow.value &&
            scanData.format == BarcodeFormat.qrcode &&
            scanData.code != null) {
          errorAlertAllow(false);
          qrCodeHandler(scanData.code!);
        }
      } catch (error) {
        showErrorAlert(error.toString());
      }
    });
  }

  void pickQRCodeFromGallery() async {
    try {
      await Permission.photos.request();
      if (await Permission.photos.isPermanentlyDenied) {
        await Permission.photos.request();
        showErrorAlert(
            'Перейдите в раздел "Разрешения" в настройках приложения Kivach Life на вашем устройстве и добавьте разрешение для чтений изображений.',
            duration: const Duration(seconds: 5));
        return;
      }
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        Clipboard.setData(ClipboardData(text: file.path));
        var qrResult = await Scan.parse(file.path);
        if (qrResult != null) {
          qrCodeHandler(qrResult);
          return;
        }
        showErrorAlert('QR-код не распознан.');
      }
    } catch (_) {
      showErrorAlert('Файл не распознан или повреждён.');
    }
  }

  void qrCodeHandler(String qrcode) async {
    try {
      const registrationPattern = 'register?_token=';
      const loginPattern = 'login?_token=';
      if (qrcode.contains(registrationPattern)) {
        final registrationToken = qrcode.split(registrationPattern)[1];
        final profilePreview = await _registrationRepository
            .checkRegistrationToken(registrationToken);
        Get.off(() => RegistrationPage(
              registrationToken: registrationToken,
              profilePreview: profilePreview,
            ));
        return;
      } else if (qrcode.contains(loginPattern)) {
        final loginToken = qrcode.split(loginPattern)[1];
        final tokenDto = await _resetPasswordByEmailRepository.sendCode(token: loginToken);
        await _tokenRepository.saveTokens(token: tokenDto);
        BlocProvider.of<AuthenticationBloc>(Get.context!)
            .add(const AuthenticateByToken());
        return;
      }
      showErrorAlert('Неверный QR-код.');
    } catch (error) {
      showErrorAlert(error.toString());
    }
  }

  void toggleFlashlight() {
    qrViewController
      ?..toggleFlash()
      ..getFlashStatus().then(
        (status) => flashlight(status),
      );
  }
}
