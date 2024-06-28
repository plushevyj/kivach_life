import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../modules/in_app_update/bloc/in_app_update_bloc.dart';
import '/core/themes/light_theme.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  static const route = '/loading';
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void dispose() {
    Get.context!.read<InAppUpdateBloc>().add(const CheckVersionApp());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: KivachColors.green,
        ),
      ),
    );
  }
}
