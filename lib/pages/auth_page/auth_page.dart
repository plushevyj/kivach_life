import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/first_opening_app/controller/first_opening_app_controller.dart';
import '../../widgets/inputs/button_for_form.dart';
import '../../widgets/inputs/text_field_for_form.dart';
import '/core/themes/light_theme.dart';

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
          padding: pagePadding,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 75,
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller: loginController,
                  hint: 'Логин',
                ),
                const SizedBox(height: 20),
                TextFieldForForm(
                  controller: passwordController,
                  hint: 'Пароль',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ButtonForForm(
                  text: 'ВОЙТИ',
                  onPressed: () {},
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/registration/qr'),
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(color: KivachColors.green),
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
