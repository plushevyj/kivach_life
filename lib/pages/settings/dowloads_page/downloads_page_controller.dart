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
    filePaths
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    namesOfFiles = filePaths
        .map((filePath) => filePath.path.replaceAll('${directory.path}/', ''))
        .toList();
    isLoading(false);
    super.onInit();
  }
}
