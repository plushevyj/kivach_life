import 'package:doctor/pages/home_page/home_page_controller.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../widgets/modal/logout_dialog.dart';
import '/pages/settings/new_local_password_page/new_local_password_page.dart';
import '/modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import '/core/themes/light_theme.dart';
import '/modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import 'settings_page_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsPageController = Get.put(SettingsPageController());
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalPasswordSettingBloc, LocalPasswordSettingState>(
          listener: (_, state) {
            if (state is ProofedOfIdentity) {
              Get.to(const NewLocalPasswordPage());
            } else if (state is DeletedLocalPassword) {
              settingsPageController.enableLocalPassword(false);
            } else if (state is SuccessfulPasswordChange) {
              settingsPageController.enableLocalPassword(true);
            }
          },
        ),
        BlocListener<BiometricSettingsBloc, BiometricSettingsState>(
          listener: (_, state) {
            if (state is ChangedUserBiometricSetting) {
              settingsPageController.enableBiometric(state.isEnable);
            } else if (state is ErrorBiometricSettings) {
              showErrorAlert(state.error);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Настройки'),
        ),
        body: Obx(
          () => settingsPageController.isPageLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: KivachColors.green,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TitleWidget(title: 'ВХОД В ПРИЛОЖЕНИЕ'),
                    if (!settingsPageController.enableLocalPassword.value)
                      _SettingButton(
                        title: 'По цифровому паролю',
                        icon: Icons.lock,
                        onPressed: () => Get.context!
                            .read<LocalPasswordSettingBloc>()
                            .add(const CreatePassword()),
                      )
                    else ...[
                      _SettingButton(
                        title: 'Изменить цифровой пароль',
                        icon: Icons.lock_outlined,
                        onPressed: () => Get.context!
                            .read<LocalPasswordSettingBloc>()
                            .add(const CreatePassword()),
                      ),
                      _SettingButton(
                        title: 'Удалить цифровой пароль',
                        icon: Icons.lock_open_outlined,
                        onPressed: () => Get.context!
                            .read<LocalPasswordSettingBloc>()
                            .add(const DeleteLocalPassword()),
                      ),
                    ],
                    if (settingsPageController.canAuthByBiometric.value)
                      _SettingButton(
                        title: 'По отпечатку пальца или скану лица',
                        icon: Icons.fingerprint,
                        onPressed: () => Get.context!
                            .read<BiometricSettingsBloc>()
                            .add(EnableBiometricsLogin(
                                !settingsPageController.enableBiometric.value)),
                        comment: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                            trackOutlineColor:
                                MaterialStateProperty.all(Colors.transparent),
                            value: settingsPageController.enableBiometric.value,
                            onChanged: (_) => Get.context!
                                .read<BiometricSettingsBloc>()
                                .add(EnableBiometricsLogin(
                                    !settingsPageController
                                        .enableBiometric.value)),
                          ),
                        ),
                      ),
                    const _TitleWidget(title: 'ПРОФИЛЬ'),
                    _SettingButton(
                      title: 'Настройки профиля',
                      icon: Icons.person,
                      iconBackgroundColor: Colors.green,
                      onPressed: () {
                        Get.find<HomePageController>()
                            .loadBaseSiteRoute(route: '/profile');
                        Get.back();
                      },
                    ),
                    _SettingButton(
                      title: 'Выйти из аккаунта',
                      icon: Icons.logout,
                      iconBackgroundColor: Colors.pink,
                      onPressed: () => showLogOutAlert(),
                    ),
                  ],
                ),
        ),
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
    this.iconBackgroundColor = Colors.red,
    this.comment,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color iconBackgroundColor;
  final VoidCallback? onPressed;
  final Widget? comment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10).add(pagePadding),
        ),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      clipBehavior: Clip.antiAlias,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBackgroundColor,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: Get.width * 0.6,
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
          Flexible(
            child: comment ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.black.withOpacity(0.5),
                ),
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
        vertical: 8,
      ).add(pagePadding),
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
