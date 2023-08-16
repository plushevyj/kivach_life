import 'package:doctor/modules/first_opening_app/controller/first_opening_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/dependencies/injector.dart';
import 'core/pages.dart';
import 'core/themes/light_theme.dart';
import 'modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import 'modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import '/modules/authentication/bloc/authentication_bloc.dart';
import '/modules/authentication/repository/login_repository.dart';

void main() async {
  await initializeDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localPasswordSettingBloc = LocalPasswordSettingBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                AuthenticationBloc()..add(const AuthenticationAppStarted())),
        BlocProvider(
            create: (_) =>
                LocalAuthenticationBloc()..add(const LocallyAuthStarted())),
        BlocProvider(create: (_) => localPasswordSettingBloc),
        BlocProvider(
            create: (_) => BiometricSettingsBloc(
                localPasswordSettingBloc: localPasswordSettingBloc)),
      ],
      child: GetMaterialApp(
        title: 'Kivach Life',
        theme: lightTheme,
        getPages: pages,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              // if (state is AuthenticationLoading) {
              //   Get.offNamed('/loading');
              // } else if (state is Authenticated) {
              //   Get.offNamed('/local_auth');
              // } else {
              //   Get.offNamed('/auth');
              // }
            },
            child: child,
          );
        },
        // initialRoute: '/loading',
        initialRoute: '/greeting_onboarding',
      ),
    );
  }
}
