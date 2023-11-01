import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:doctor/core/themes/light_theme.dart';
import 'package:doctor/pages/documents_pages/document_view_page.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart' as path;

import '../../../core/constants.dart';

class DownloadDocumentRepository {
  Future<String?> downloadFile({
    required String url,
    Directory? saveDirectory,
    bool showProgressAlert = false,
    Map<String, String> headers = const {},
  }) async {
    saveDirectory ??= await documentsDirectory;
    if (!await saveDirectory.exists()) {
      saveDirectory.create();
    }
    var fileName = path.basename(url);
    if (showProgressAlert) {
      showMessageAlert(
        title: 'Идёт загрузка',
        message:
            'Файл загружается в папку ${GetPlatform.isIOS ? '/iPhone/Kivach Life' : '/Внутреннее хранилище/Загрузки/Kivach Life'}',
        icon: const Icon(Icons.download_rounded, color: KivachColors.green),
      );
    }
    final response = await handleRequest(() => Dio().download(
          url,
          '${saveDirectory?.path}/$fileName',
          options: Options(headers: headers),
        ));
    if (!fileName.contains('.')) {
      final type =
          Mime.getExtensionsFromType(response.headers.value('content-type')!);
      if (type != null && type.isNotEmpty) {
        File('${saveDirectory.path}/$fileName')
            .rename('${saveDirectory.path}/$fileName.${type.first}');
        fileName = '$fileName.${type.first}';
      }
    }
    if (response.statusCode == 200) {
      if (showProgressAlert) {
        showMessageAlert(
          title: 'Сохранено',
          message:
              'Файл сохранен $fileName в папку ${GetPlatform.isIOS ? '/iPhone/Kivach Life' : '/Внутреннее хранилище/Загрузки/Kivach Life'}',
          icon: const Icon(Icons.download_done_rounded,
              color: KivachColors.green),
          mainButton: TextButton(
            onPressed: () {
              Get.to(
                  DocumentViewPage(path: '${saveDirectory?.path}/$fileName'));
              Get.closeCurrentSnackbar();
            },
            child: const Text(
              'Открыть в\nприложении',
              textAlign: TextAlign.center,
              style: TextStyle(color: KivachColors.green),
            ),
          ),
        );
      }
    }
    return '${saveDirectory.path}/$fileName';
  }
}
