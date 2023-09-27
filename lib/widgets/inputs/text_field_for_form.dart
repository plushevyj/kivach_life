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
    this.onSubmitted,
    this.errorText,
    this.errorStyle,
  });

  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final String? errorText;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    return isPassword
        ? GetX(
            init: VisibilityTextController(),
            global: false,
            builder: (logic) {
              return TextFormField(
                obscureText: logic.visibilityText.value,
                controller: controller,
                textInputAction: TextInputAction.next,
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
                  errorText: errorText,
                  errorStyle: errorStyle,
                ),
                autocorrect: false,
              );
            },
          )
        : TextFormField(
            controller: controller,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: hint,
              errorText: errorText,
              errorStyle: errorStyle,
            ),
            autocorrect: false,
          );
  }
}
