import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'qr_scanner_page_controller.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    final controller = Get.put(QRScannerPageController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Отсканируйте QR-код',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FutureBuilder(
            future: controller.qrViewController?.getFlashStatus(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.flashlight.value
                              ? Icons.flash_off
                              : Icons.flash_on,
                          color: Colors.white,
                        ),
                        onPressed: () => controller.toggleFlashlight(),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: controller.onQRViewCreated,
            formatsAllowed: const [BarcodeFormat.qrcode],
          ),
          const _CameraBorder(),
          Positioned(
            left: 4,
            bottom: 4,
            child: IconButton(
              onPressed: () {
                controller.pickQRCodeFromGallery();
              },
              icon: const Icon(
                Icons.photo_library_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _borderSide1 = 10.0;
const _borderSide2 = 40.0;
const _radiusOfBorderSide = 10.0;

class _CameraBorder extends StatelessWidget {
  const _CameraBorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 90;
    final halfHeight = MediaQuery.of(context).size.height / 2;
    final halfWidth =
        (MediaQuery.of(context).size.width - horizontalPadding * 2) / 2;
    return Stack(
      children: [
        Positioned(
          top: halfHeight - halfWidth,
          left: horizontalPadding,
          child: const _HorizontalStick(),
        ),
        Positioned(
          top: halfHeight - halfWidth,
          left: horizontalPadding,
          child: const _VerticalStick(),
        ),
        Positioned(
          top: halfHeight - halfWidth,
          right: horizontalPadding,
          child: const _HorizontalStick(),
        ),
        Positioned(
          top: halfHeight - halfWidth,
          right: horizontalPadding,
          child: const _VerticalStick(),
        ),
        Positioned(
          top: halfHeight + halfWidth + _borderSide1 - _borderSide2,
          left: horizontalPadding,
          child: const _VerticalStick(),
        ),
        Positioned(
          top: halfHeight + halfWidth,
          left: horizontalPadding,
          child: const _HorizontalStick(),
        ),
        Positioned(
          top: halfHeight + halfWidth + _borderSide1 - _borderSide2,
          right: horizontalPadding,
          child: const _VerticalStick(),
        ),
        Positioned(
          top: halfHeight + halfWidth,
          right: horizontalPadding,
          child: const _HorizontalStick(),
        ),
      ],
    );
  }
}

class _VerticalStick extends StatelessWidget {
  const _VerticalStick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _borderSide1,
      height: _borderSide2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radiusOfBorderSide),
      ),
    );
  }
}

class _HorizontalStick extends StatelessWidget {
  const _HorizontalStick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _borderSide2,
      height: _borderSide1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radiusOfBorderSide),
      ),
    );
  }
}
