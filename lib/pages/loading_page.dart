import 'package:flutter/material.dart';

import '/core/themes/light_theme.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: KivachColors.green,),
      ),
    );
  }
}
