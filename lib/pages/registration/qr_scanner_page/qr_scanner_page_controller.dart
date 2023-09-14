import 'dart:async';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void dispose() {
    result.close();
    qrViewController?.dispose();
    flashlight.close();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) async {
    qrViewController = controller;

    controller.scannedDataStream.listen((Barcode scanData) async {
      try {
        if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
          Timer(const Duration(milliseconds: 1), () async {
            qrCodeHandler(scanData.code!);
          });
        }
      } catch (error) {
        showErrorAlert(error.toString());
      }
    });
  }

  void pickQRCodeFromGallery() async {
    try {
      final file = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
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
  }

  void toggleFlashlight() {
    qrViewController
      ?..toggleFlash()
      ..getFlashStatus().then(
        (status) => flashlight(status),
      );
  }
}
