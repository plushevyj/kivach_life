import 'package:doctor/modules/in_app_update/bloc/in_app_update_bloc.dart';
import 'package:doctor/modules/reset_password/bloc/reset_password_bloc.dart';
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
        BlocProvider(create: (_) => InAppUpdateBloc()),
        BlocProvider(
            create: (_) =>
                AuthenticationBloc()..add(const AuthenticateByToken())),
        BlocProvider(create: (_) => LocalAuthenticationBloc()),
        BlocProvider(create: (_) => ResetPasswordBloc()),
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
              if (state is Authenticated) {
                Get.offNamed('/local_auth');
                // } else if (state is Unauthenticated) {
                //   Get.offAllNamed('/local_auth');
              } else {
                Get.offNamed('/auth');
              }
            },
            child: child,
          );
        },
        initialRoute: '/loading',
        // initialRoute: '/onboarding_greeting',
      ),
    );
  }
}
