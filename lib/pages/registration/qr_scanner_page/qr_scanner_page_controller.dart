import 'dart:async';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../registration_page/registration_page.dart';
import '/widgets/alerts.dart';
import '../../../modules/registration/repository/registration_repository.dart';

class QRScannerPageController extends GetxController {
  final result = Rxn<Barcode>();
  final flashlight = false.obs;
  QRViewController? qrViewController;
  final _registrationRepository = const RegistrationRepository();
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
    controller.scannedDataStream.listen((Barcode scanData) async {
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
      const pattern = 'register?_token=';
      if (qrcode.contains(pattern)) {
        final registrationToken = qrcode.split(pattern)[1];
        final profilePreview = await _registrationRepository
            .checkRegistrationToken(registrationToken);
        Get.off(RegistrationPage(
          registrationToken: registrationToken,
          profilePreview: profilePreview,
        ));
        return;
      }
      showErrorAlert('Неверный QR-код.');
    } catch (error) {
      rethrow;
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
