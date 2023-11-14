import 'package:doctor/pages/documents_pages/document_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/light_theme.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            child: Text(
              'Скачанные файлы сохраняются в папку\n${GetPlatform.isIOS ? '/iPhone/Kivach Life' : '/Внутреннее хранилище/Загрузки/Kivach Life'}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (downloadsPageController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (downloadsPageController.filePaths.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: downloadsPageController.filePaths.length,
                    itemBuilder: (_, index) {
                      return _FileButton(
                        name: downloadsPageController.namesOfFiles[index],
                        path: downloadsPageController.filePaths[index].path,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Список пуст',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FileButton extends StatelessWidget {
  const _FileButton({
    Key? key,
    required this.name,
    required this.path,
  }) : super(key: key);

  final String name;
  final String path;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10).add(pagePadding),
        ),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      clipBehavior: Clip.antiAlias,
      onPressed: name.contains(RegExp(r'.pdf|.doc|.docx'))
          ? () => Get.to(DocumentViewPage(path: path))
          : () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.file_copy_outlined,
                color: KivachColors.green,
                size: 20,
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          if (name.contains(RegExp(r'.pdf|.doc|.docx')))
            const Flexible(
              child: Icon(
                Icons.open_in_new,
                color: KivachColors.green,
              ),
            ),
        ],
      ),
    );
  }
}
