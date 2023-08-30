import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class VisibilityTextController extends GetxController {
  final visibilityText = true.obs;
}

class TextFieldForForm extends StatefulWidget {
  const TextFieldForForm({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final FormFieldValidator<String?>? validator;

  @override
  State<TextFieldForForm> createState() => _TextFieldForFormState();
}

class _TextFieldForFormState extends State<TextFieldForForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60,
      child: widget.isPassword
          ? GetX(
              init: VisibilityTextController(),
              global: false,
              builder: (logic) {
                return TextFormField(
                  obscureText: logic.visibilityText.value,
                  controller: widget.controller,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: widget.hint,
                    suffixIcon: widget.isPassword
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
                  validator: widget.validator,
                );
              },
            )
          : TextFormField(
              controller: widget.controller,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: widget.hint,
              ),
              autocorrect: false,
              validator: widget.validator,
            ),
    );
  }
}
