// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// import '/modules/local_authentication/bloc/local_authentication_bloc.dart';
//
// class LoadingLocalPage extends StatelessWidget {
//   const LoadingLocalPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LocalAuthenticationBloc, LocalAuthenticationState>(
//       listener: (context, state) {
//         if (state is LocallyAuthenticated) {
//           Get.offNamed('/home');
//         } else {
//           Get.offNamed('/local_auth');
//         }
//       },
//       child: const Scaffold(body: Center(child: CircularProgressIndicator())),
//     );
//   }
// }
