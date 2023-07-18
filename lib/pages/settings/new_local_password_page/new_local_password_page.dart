import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '/modules/new_local_password/bloc/new_local_password_bloc.dart';
import '/widgets/digital_input/digital_input_widget.dart';
import '/widgets/digital_input/digital_field.dart';
import '/pages/settings/new_local_password_page/new_password_controller.dart';
import 'package:animations/animations.dart';

class NewLocalPasswordPage extends StatelessWidget {
  const NewLocalPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newLocalPasswordController = Get.put(NewLocalPasswordController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Get.back(),
        ),
      ),
      body: BlocConsumer<NewLocalPasswordBloc, NewLocalPasswordState>(
        listener: (_, state) {
          newLocalPasswordController.firstPassword.clear();
          newLocalPasswordController.secondPassword.clear();
          if (state is NewLocalPasswordInitialState ||
              state is InvalidConfirmedNewLocalPassword) {
            newLocalPasswordController.onFirstPage(false);
          } else if (state is GotFirstLocalPassword) {
            newLocalPasswordController.onFirstPage(true);
          }
        },
        builder: (context, state) {
          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: !newLocalPasswordController.onFirstPage.value,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child);
            },
            child: state is NewLocalPasswordInitialState ||
                    state is InvalidConfirmedNewLocalPassword
                ? _LocalPasswordSettingBody(
                    key: UniqueKey(),
                    controller: newLocalPasswordController.firstPassword,
                    idEnabled: newLocalPasswordController
                        .enableDialButtonsOfPassword.value,
                    title: 'ПРИДУМАЙТЕ ПАРОЛЬ',
                  )
                : state is GotFirstLocalPassword
                    ? _LocalPasswordSettingBody(
                        key: UniqueKey(),
                        controller: newLocalPasswordController.secondPassword,
                        idEnabled: newLocalPasswordController
                            .enableDialButtonsOfConfirmedPassword.value,
                        title: 'ПОДТВЕРДИТЕ ПАРОЛЬ',
                      )
                    : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
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
              maxLength: maxLengthLocalPassword,
            ),
          ),
          const SizedBox(height: 150),
          DigitalInput(
            controller: controller,
            maxLength: maxLengthLocalPassword,
            isEnabled: idEnabled,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
