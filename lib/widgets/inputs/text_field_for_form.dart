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
    this.autofillHints,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: hint,
        errorText: errorText,
        errorStyle: errorStyle,
      ),
      autocorrect: false,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
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
    this.autofillHints,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final TextStyle? errorStyle;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: VisibilityPasswordController(),
      global: false,
      builder: (logic) {
        return TextField(
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
          autofillHints: autofillHints,
        );
      },
    );
  }
}
