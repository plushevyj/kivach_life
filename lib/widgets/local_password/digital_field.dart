import 'package:flutter/material.dart';

class DigitalField extends StatelessWidget {
  const DigitalField({
    Key? key,
    required this.controller,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLength;

  static const _circleFieldSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [for (int i = 1; i <= maxLength; i++) i]
          .map(
            (el) => ValueListenableBuilder(
              valueListenable: controller,
              builder: (_, value, __) {
                return Container(
                  width: _circleFieldSize,
                  height: _circleFieldSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value.text.length < el ? Colors.grey : Colors.green,
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
