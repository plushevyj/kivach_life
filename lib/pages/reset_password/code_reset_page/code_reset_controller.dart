import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeResetController extends GetxController {
  CodeResetController({this.remainingTime = 60});

  final int remainingTime;

  final textController = TextEditingController();
  late RxnString timerMessage;
  final isLoading = false.obs;

  @override
  void onInit() {
    final difference = Duration(seconds: remainingTime);
    timerMessage = RxnString('${twoDigits(difference.inMinutes.remainder(60))}:'
        '${twoDigits(difference.inSeconds.remainder(60))}');
    startTimer(remainingTime);
    super.onInit();
  }

  @override
  void dispose() {
    textController.dispose();
    timerMessage.close();
    isLoading.close();
    super.dispose();
  }

  String twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  void startTimer(int duration) {
    var remind = duration;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remind <= 0) {
          timerMessage.value = null;
          timer.cancel();
        } else {
          final difference = Duration(seconds: remind--);
          timerMessage('${twoDigits(difference.inMinutes.remainder(60))}:'
              '${twoDigits(difference.inSeconds.remainder(60))}');
        }
      },
    );
  }
}
