import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

import '/modules/new_local_password/bloc/new_local_password_bloc.dart';
import '/widgets/digital_input/digital_input_widget.dart';
import '../../local_auth_page/local_password_controller.dart';
import '/widgets/digital_input/digital_field.dart';
import '/pages/settings/new_local_password_page/new_password_controller.dart';

class NewLocalPasswordPage extends StatelessWidget {
  const NewLocalPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewLocalPasswordBloc(),
        child: const _NewLocalPasswordPageView());
  }
}

class _NewLocalPasswordPageView extends StatelessWidget {
  const _NewLocalPasswordPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        final newLocalPasswordController = Get.put(NewLocalPasswordController());
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () => Get.back(),
            ),
          ),
          body: BlocBuilder<NewLocalPasswordBloc, NewLocalPasswordState>(
            builder: (context, state) {
              if (state is NewLocalPasswordInitialState) {
                return Obx(() {
                  return _LocalPasswordSettingBody(
                    controller: newLocalPasswordController.password,
                    idEnabled: newLocalPasswordController
                        .enableDialButtonsOfPassword.value,
                    title: 'ПРИДУМАЙТЕ ПАРОЛЬ',
                  );
                });
              } else if (state is GotNewLocalPassword) {
                return Obx(() {
                  return _LocalPasswordSettingBody(
                    controller: newLocalPasswordController.confirmedPassword,
                    idEnabled: newLocalPasswordController
                        .enableDialButtonsOfConfirmedPassword.value,
                    title: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                  );
                });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }
    );
  }
}

class _LocalPasswordSettingBody extends StatelessWidget {
  const _LocalPasswordSettingBody({
    Key? key,
    required this.controller,
    required this.idEnabled,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final bool idEnabled;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 150,
            child: DigitalField(
              controller: controller,
              maxLength: LocalPasswordController.maxLengthLocalPassword,
            ),
          ),
          const SizedBox(height: 150),
          DigitalInput(
            controller: controller,
            maxLength: LocalPasswordController.maxLengthLocalPassword,
            isEnabled: idEnabled,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
