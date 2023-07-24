import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/inputs/auth_button.dart';
import '../../widgets/inputs/auth_text_field.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextField(
                  controller: loginController,
                  hint: 'Логин',
                ),
                const SizedBox(height: 20),
                AuthTextField(
                  controller: passwordController,
                  hint: 'Пароль',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                AuthButton(
                  text: 'ВОЙТИ',
                  onPressed: () => Get.toNamed('registration'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
