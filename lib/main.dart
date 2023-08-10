import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/dependencies/injector.dart';
import 'core/pages.dart';
import 'core/themes/light_theme.dart';
import 'modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import 'modules/first_opening_of_app/bloc/first_opening_of_app_bloc.dart';
import 'modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'modules/local_password_settings/bloc/local_password_settings_bloc.dart';

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
                LocalAuthenticationBloc()..add(const LogOutLocally())),
        BlocProvider(create: (_) => localPasswordSettingBloc),
        BlocProvider(
            create: (_) => BiometricSettingsBloc(
                localPasswordSettingBloc: localPasswordSettingBloc)),
        BlocProvider(
            create: (_) =>
                FirstOpeningOfAppBloc()..add(const CheckFirstOpeningOfApp())),
      ],
      child: GetMaterialApp(
        title: 'Kivach Life',
        theme: lightTheme,
        getPages: pages,
        builder: (context, child) {
          return BlocListener<LocalAuthenticationBloc,
              LocalAuthenticationState>(
            listener: (context, state) {
              // if (state is LocallyAuthenticated) {
              //   Get.offNamed('/home');
              // } else if (state is LocallyNotAuthenticated) {
              //   Get.offNamed('/local_auth');
              // } else {
              //   Get.offNamed('/local_auth');
              // }
            },
            child: child,
          );
        },
        initialRoute: initialRoute,
      ),
    );
  }
}
