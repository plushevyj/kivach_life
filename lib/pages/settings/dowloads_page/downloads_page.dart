import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'downloads_page_controller.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadsPageController = Get.put(DownloadsPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Загрузки'),
      ),
      body: Obx(
        () {
          if (downloadsPageController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: downloadsPageController.filePaths.length,
              itemBuilder: (_, index) {
                return Text(downloadsPageController.namesOfFiles[index]);
              },
            );
          }
        },
      ),
    );
  }
}
