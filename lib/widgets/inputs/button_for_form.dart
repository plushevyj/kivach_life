import 'package:flutter/material.dart';

import '../../core/themes/light_theme.dart';

class ButtonForForm extends StatelessWidget {
  const ButtonForForm({
    Key? key,
    this.text,
    this.child,
    required this.onPressed,
  })  : assert(
            (text != null && child == null) || (text == null && child != null),
            '\n\nAs content, [ButtonForForm] can contain either [text] or [child].'),
        super(key: key);

  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child ??
          Text(
            text!,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.white,
            ),
          ),
    );
  }
}
