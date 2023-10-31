import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';

import '../../../core/constants.dart';

class DownloadDocumentRepository {
  // Возвращает путь к файлу
  Future<void> downloadFile({
    required String url,
    Directory? saveDirectory,
    bool showProgressAlert = false,
    Map<String, String> headers = const {},
  }) async {
    saveDirectory ??= await documentsDirectory;
    if (!await saveDirectory.exists()) {
      saveDirectory.create();
    }
    // final formattedTime = DateFormat('yyyy_MM_dd_Hms').format(DateTime.now());
    // final fileName = '${formattedTime}_${url.split('/').last}';
    try {
      await FlutterDownloader.enqueue(
        url: url,
        headers: headers,
        savedDir: saveDirectory.path,
        fileName: null,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
    } catch (_) {}
  }
}
