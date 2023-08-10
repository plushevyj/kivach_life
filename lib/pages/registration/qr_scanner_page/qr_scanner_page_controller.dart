import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPageController extends GetxController {
  final result = Rxn<Barcode>();
  final flashlight = false.obs;
  QRViewController? qrViewController;

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) async {
    qrViewController = controller;
    controller.scannedDataStream.listen((Barcode scanData) {
      if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
        Get.offNamed('/registration/${scanData.code}');
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
