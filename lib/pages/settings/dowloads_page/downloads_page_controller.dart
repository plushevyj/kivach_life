import 'dart:io';

import 'package:get/get.dart';

import '../../../core/utils/constants.dart';

class DownloadsPageController extends GetxController {
  var isLoading = true.obs;
  List<FileSystemEntity> filePaths = [];
  List<String> namesOfFiles = [];

  @override
  void onInit() async {
    final directory = await documentsDirectory;
    filePaths = Directory(directory.path).listSync();
    filePaths.removeWhere((filePath) => filePath.path.contains('.Trash'));
    namesOfFiles = filePaths
        .map((filePath) => filePath.path.replaceAll('${directory.path}/', ''))
        .toList();
    print(filePaths);
    print(namesOfFiles);
    isLoading(false);
    super.onInit();
  }
}
