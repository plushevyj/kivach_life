import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeResetController extends GetxController {
  late int _start;

  final textController = TextEditingController();
  var timerMessage = RxnString('01:00');
  final isLoading = false.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    textController.dispose();
    timerMessage.close();
    isLoading.close();
    super.dispose();
  }

  void startTimer() {
    _start = 60;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_start <= 0) {
          timerMessage.value = null;
          timer.cancel();
        } else {
          final difference = Duration(seconds: _start--);
          timerMessage('${twoDigits(difference.inMinutes.remainder(60))}:'
              '${twoDigits(difference.inSeconds.remainder(60))}');
        }
      },
    );
  }
}
