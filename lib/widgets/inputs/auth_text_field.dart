import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisibilityTextController extends GetxController {
  final visibilityText = true.obs;
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
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
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2,
        color: Colors.green,
      ),
    );
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
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    labelText: hint,
                    labelStyle: const TextStyle(color: Colors.green),
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(logic.visibilityText.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              logic.visibilityText(!logic.visibilityText.value);
                            },
                            color: Colors.green,
                          )
                        : null,
                  ),
                  autocorrect: false,
                );
              },
            )
          : TextField(
              controller: controller,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                border: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                labelText: hint,
                labelStyle: const TextStyle(color: Colors.green),
              ),
              autocorrect: false,
            ),
    );
  }
}
