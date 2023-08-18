import 'dart:async';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
          Future.delayed(const Duration(seconds: 1), () {
            if (scanData.code!.contains(pattern)) {
              Get.offNamed('/registration/${scanData.code}');
              // showErrorAlert('QR-код неверный');
            }
          });
        }
      } catch (error) {
        showErrorAlert(error.toString());
        print(error);
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
