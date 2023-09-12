import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.center,
        color: Colors.pink,
        // we can set width here with conditions
        width: 200,
        height: Get.statusBarHeight,
        child: const Text("MY AppBar"),
      ),
    );
  }

  ///width doesnt matter
  @override
  Size get preferredSize => Size(800, Get.statusBarHeight);
}
