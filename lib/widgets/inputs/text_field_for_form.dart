import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisibilityTextController extends GetxController {
  final visibilityText = true.obs;
}

class TextFieldForForm extends StatelessWidget {
  const TextFieldForForm({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: isPassword
          ? GetX(
              init: VisibilityTextController(),
              global: false,
              builder: (logic) {
                return TextField(
                  obscureText: logic.visibilityText.value,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: hint,
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(logic.visibilityText.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              logic.visibilityText(!logic.visibilityText.value);
                            },
                          )
                        : null,
                  ),
                  autocorrect: false,
                );
              },
            )
          : TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: hint,
              ),
              autocorrect: false,
            ),
    );
  }
}
