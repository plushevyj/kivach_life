import 'package:doctor/modules/in_app_update/bloc/in_app_update_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/inputs/button_for_form.dart';
import '../../widgets/inputs/text_field_for_form.dart';
import '/core/themes/light_theme.dart';
import 'auth_page_controller.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '/widgets/alerts.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPageController = Get.put(AuthPageController());
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationLoading) {
          FocusScope.of(context).requestFocus(FocusNode());
          authPageController.isLoading(true);
        } else if (state is Unauthenticated) {
          authPageController.isLoading(false);
        } else if (state is AuthenticationError) {
          showErrorAlert(state.error);
          authPageController.isLoading(false);
        }
      },
      child: Scaffold(
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
                    width: 250,
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
                    onSubmitted: (_) {
                      if (loginController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        Get.context!.read<AuthenticationBloc>().add(
                              LogIn(
                                username: loginController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => ButtonForForm(
                      text:
                          !authPageController.isLoading.value ? 'ВОЙТИ' : null,
                      child: authPageController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : null,
                      onPressed: () {
                        if (loginController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          Get.context!.read<AuthenticationBloc>().add(
                                LogIn(
                                  username: loginController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Get.toNamed('/reset'),
                    child: const Text(
                      'Забыли пароль?',
                      style: TextStyle(color: KivachColors.green),
                    ),
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
      ),
    );
  }
}
