import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const _horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleWidget(title: 'ВХОД В ПРИЛОЖЕНИЕ'),
          _SettingButton(
            title: 'По цифровому паролю',
            icon: Icons.lock_outline,
            onPressed: () {},
          ),
          _SettingButton(
            title: 'По отпечатку пальца или скану лица',
            icon: Icons.fingerprint,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingButton extends StatelessWidget {
  const _SettingButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
              horizontal: SettingsPage._horizontalPadding, vertical: 10),
        ),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
      clipBehavior: Clip.antiAlias,
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: Get.width * 0.7,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SettingsPage._horizontalPadding,
        vertical: 8,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
