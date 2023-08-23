import 'dart:async';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
    const pattern = 'register?_token=';
    controller.scannedDataStream.listen((Barcode scanData) async {
      try {
        if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
          Timer(const Duration(milliseconds: 1), () async {
            if (scanData.code!.contains(pattern)) {
              final registrationToken = scanData.code!.split(pattern)[1];
              final profilePreview = await _registrationRepository
                  .checkRegistrationToken(registrationToken);
              Get.off(RegistrationPage(
                registrationToken: registrationToken,
                profilePreview: profilePreview,
              ));
              // showErrorAlert('QR-код неверный');
            }
          });
        }
      } catch (error) {
        showErrorAlert(error.toString());
      }
    });
  }

  void toggleFlashlight() {
    qrViewController
      ?..toggleFlash()
      ..getFlashStatus().then(
        (status) => flashlight(status),
      );
  }
}
