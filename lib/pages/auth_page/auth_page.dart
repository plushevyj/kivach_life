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
          child: Obx(
            () => Align(
              alignment: authPageController.isKeyBoardVisible.value
                  ? Alignment.topCenter
                  : Alignment.center,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20).add(pagePadding),
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 250,
                        ),
                        const SizedBox(height: 20),
                        TextFieldForForm(
                          controller: loginController,
                          hint: 'Логин',
                          autofillHints: const [AutofillHints.username],
                        ),
                        const SizedBox(height: 20),
                        PasswordFieldForForm(
                          controller: passwordController,
                          hint: 'Пароль',
                          autofillHints: const [AutofillHints.password],
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => ButtonForForm(
                            text: !authPageController.isLoading.value
                                ? 'ВОЙТИ'
                                : null,
                            child: authPageController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
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
          ),
        ),
      ),
    );
  }
}
