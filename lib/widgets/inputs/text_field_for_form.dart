import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldForForm extends StatelessWidget {
  const TextFieldForForm({
    super.key,
    required this.controller,
    required this.hint,
    this.errorText,
    this.errorStyle,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: hint,
        errorText: errorText,
        errorStyle: errorStyle,
      ),
      autocorrect: false,
      keyboardType: keyboardType,
    );
  }
}

class VisibilityPasswordController extends GetxController {
  final visibilityText = true.obs;
}

class PasswordFieldForForm extends StatelessWidget {
  const PasswordFieldForForm({
    super.key,
    required this.controller,
    required this.hint,
    this.errorText,
    this.errorStyle,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: VisibilityPasswordController(),
      global: false,
      builder: (logic) {
        return TextFormField(
          obscureText: logic.visibilityText.value,
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: hint,
            suffixIcon: IconButton(
              icon: Icon(logic.visibilityText.value
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                logic.visibilityText(!logic.visibilityText.value);
              },
            ),
            errorText: errorText,
            errorStyle: errorStyle,
          ),
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
        );
      },
    );
  }
}
