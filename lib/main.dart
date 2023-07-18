import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/core/dependencies/injector.dart';
import 'core/pages.dart';
import 'core/themes/light_theme.dart';
import 'modules/local_authentication/bloc/local_authentication_bloc.dart';
import 'modules/new_local_password/bloc/new_local_password_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                LocalAuthenticationBloc()..add(const LogOutLocally())),
        BlocProvider(create: (_) => NewLocalPasswordBloc()),
      ],
      child: GetMaterialApp(
        title: 'Кивач',
        theme: lightTheme,
        // darkTheme: ThemeData(
        //   useMaterial3: true,
        // ),
        getPages: pages,
        builder: (context, child) {
          return BlocListener<LocalAuthenticationBloc,
              LocalAuthenticationState>(
            listener: (context, state) {
              if (state is LocallyAuthenticated) {
                Get.offNamed('/home');
              } else if (state is LocallyNotAuthenticated) {
                Get.offNamed('/local_auth');
              } else {
                Get.offNamed('/local_auth');
              }
            },
            child: child,
          );
        },
        initialRoute: initialRoute,
      ),
    );
  }
}
