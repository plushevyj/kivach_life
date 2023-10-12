import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/dependencies/injector.dart';
import 'core/firebase/firebase_api.dart';
import 'core/pages.dart';
import 'core/themes/light_theme.dart';
import 'modules/biometric_settings/bloc/biometric_settings_bloc.dart';
import 'modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'modules/local_password_settings/bloc/local_password_settings_bloc.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'modules/in_app_update/bloc/in_app_update_bloc.dart';
import 'modules/opening_app/controllers/configuration_of_app_controller.dart';
import 'modules/reset_password/bloc/reset_password_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  await initializeDependencies();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
        debugShowCheckedModeBanner: false,
        title: 'Kivach Life',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        getPages: pages,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              if (state is Authenticated) {
                await FirebaseApi().sendToken();
                Get.offNamed('/local_auth');
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
