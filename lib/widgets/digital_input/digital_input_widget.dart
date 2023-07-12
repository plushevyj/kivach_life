import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'digital_input_controller.dart';

class DigitalInput extends StatelessWidget {
  const DigitalInput({
    Key? key,
    this.onChanged,
    required this.onDone,
    this.isEnabled = true,
    this.firstAction,
    this.secondAction,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final VoidCallback onDone;
  final bool isEnabled;
  final Widget? firstAction;
  // The second action will be hidden by the backspace button if the input is not empty.
  final Widget? secondAction;

  @override
  Widget build(BuildContext context) {
    final digitalController = Get.put(DigitalController());
    return Obx(
      () {
        return GridView.count(
          mainAxisSpacing: 1,
          crossAxisSpacing: 3,
          crossAxisCount: 3,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...[for (int i = 1; i <= 9; i++) i]
                .map(
                  (number) => IconButton(
                    onPressed: digitalController.enableDialButton.value
                        ? () {
                            digitalController.enter(number);
                            if (onChanged != null) {
                              onChanged!(digitalController.value.value);
                            }
                          }
                        : null,
                    icon: Text(
                      number.toString(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                )
                .toList(),
            firstAction ?? const SizedBox.shrink(),
            IconButton(
              onPressed: digitalController.enableDialButton.value
                  ? () {
                      digitalController.enter(0);
                      if (onChanged != null) {
                        onChanged!(digitalController.value.value);
                      }
                    }
                  : null,
              icon: const Text(
                '0',
                style: TextStyle(fontSize: 30),
              ),
            ),
            digitalController.showSecondAction.value && secondAction != null
                ? secondAction!
                : IconButton(
                    onPressed: digitalController.enableDialButton.value
                        ? () => digitalController.delete()
                        : null,
                    icon: const Icon(Icons.backspace),
                  ),
          ],
        );
      },
    );
  }
}
