import 'package:flutter/material.dart';

class DigitalInput extends StatelessWidget {
  const DigitalInput({
    Key? key,
    required this.controller,
    required this.maxLength,
    this.isEnabled = true,
    this.leftWidget,
    this.leftWidgetAction,
    this.rightWidget,
    this.rightWidgetAction,
  })  : assert(
          (leftWidget == null && leftWidgetAction == null) ||
              (leftWidget != null && leftWidgetAction != null),
          '\n\nYou need to add [leftWidgetAction] to the [leftWidget] '
          'being created.',
        ),
        assert(
          (rightWidget == null && rightWidgetAction == null) ||
              (rightWidget != null && rightWidgetAction != null),
          '\n\nYou need to add [rightWidgetAction] to the [rightWidget] '
          'being created.',
        ),
        super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool isEnabled;
  final Widget? leftWidget;
  final VoidCallback? leftWidgetAction;
  // The [rightWidget] will be hidden by the backspace button if the input is not empty.
  final Widget? rightWidget;
  final VoidCallback? rightWidgetAction;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 1,
      crossAxisSpacing: 10,
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...[for (int i = 1; i <= 9; i++) i]
            .map(
              (number) => IconButton(
                onPressed: isEnabled ? () => enter(number) : null,
                icon: Text(
                  number.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            )
            .toList(),
        leftWidget != null
            ? IconButton(
                onPressed: isEnabled ? leftWidgetAction : null,
                icon: leftWidget!)
            : const SizedBox.shrink(),
        IconButton(
          onPressed: isEnabled ? () => enter(0) : null,
          icon: const Text(
            '0',
            style: TextStyle(fontSize: 30),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: controller,
          builder: (_, value, __) {
            return value.text.isEmpty && rightWidget != null
                ? IconButton(
                    onPressed: isEnabled ? rightWidgetAction : null,
                    icon: rightWidget!)
                : IconButton(
                    onPressed: isEnabled ? () => delete() : null,
                    icon: const Icon(Icons.backspace),
                  );
          },
        ),
      ],
    );
  }

  void enter(int value) {
    if (controller.text.length < maxLength) {
      controller.text += value.toString();
    }
  }

  void delete() {
    if (controller.text.isNotEmpty) {
      controller.text =
          controller.text.substring(0, controller.text.length - 1);
    }
  }
}
