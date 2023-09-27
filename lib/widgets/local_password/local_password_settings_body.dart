import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import '../../core/themes/light_theme.dart';
import 'digital_field.dart';
import 'digital_input_widget.dart';

class LocalPasswordSettingBody extends StatelessWidget {
  const LocalPasswordSettingBody({
    Key? key,
    required this.controller,
    required this.idEnabled,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final bool idEnabled;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 150,
            child: DigitalField(
              controller: controller,
              maxLength: maxLengthLocalPassword,
            ),
          ),
          SizedBox(height: Get.height * (isSmallScreen ? 0.08 : 0.15)),
          DigitalInput(
            controller: controller,
            maxLength: maxLengthLocalPassword,
            isEnabled: idEnabled,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}