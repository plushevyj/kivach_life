import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '/core/dependencies/injector.dart';
import 'core/pages.dart';
import 'modules/local_authentication/bloc/local_authentication_bloc.dart';

void main() {
  initializeDependencies();
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
      ],
      child: GetMaterialApp(
        title: 'Кивач',
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
        ),
        getPages: pages,
        builder: (context, child) {
          return BlocListener<LocalAuthenticationBloc,
              LocalAuthenticationState>(
            listener: (context, state) {
              if (state is LocallyAuthenticated) {
                // todo: add home page here
                Get.off(const Center(child: Text('It\'s working')));
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
