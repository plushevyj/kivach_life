import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:doctor/core/themes/light_theme.dart';
import 'package:doctor/pages/documents_pages/document_view_page.dart';
import 'package:doctor/widgets/alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_it/get_it.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart' as path;

import '../../../core/constants.dart';

class DownloadDocumentRepository {
  static final _dio = GetIt.I.get<Dio>();

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
    final fileName = path.basename(url);
    var finalFileName = fileName;
    if (showProgressAlert) {
      showMessageAlert(
        title: 'Идёт загрузка',
        message:
            'Файл загружается в папку ${GetPlatform.isIOS ? '/iPhone/Kivach Life' : '/Внутреннее хранилище/Загрузки/Kivach Life'}',
        icon: const Icon(Icons.download_rounded, color: KivachColors.green),
        duration: const Duration(seconds: 2),
      );
    }
    Response<dynamic>? response;
    try {
      response = await handleRequest(() => _dio.download(
            url,
            '${saveDirectory?.path}/$fileName',
            // options: Options(headers: headers),
          ));
    } catch (_) {
      showErrorAlert('Не удалось скачать файл');
    }
    if (!fileName.contains('.')) {
      final disposition = response?.headers.map['content-disposition'];
      print(disposition);
      if (disposition != null) {
        final dispositionTokens = disposition.first.split(';');
        final dispositionFileName = dispositionTokens
            .firstWhereOrNull((token) => token.contains('filename='));
        if (dispositionFileName != null) {
          finalFileName =
              dispositionFileName.replaceAll(RegExp(r'filename=|"'), '');
          finalFileName = utf8.decode(finalFileName.codeUnits);
        }
      } else {
        final type = Mime.getExtensionsFromType(
            response!.headers.value('content-type')!);
        if (type != null && type.isNotEmpty) {
          finalFileName = '$fileName.${type.first}';
        }
      }
      if (finalFileName != fileName) {
        File('${saveDirectory.path}/$fileName')
            .rename('${saveDirectory.path}/$finalFileName');
      }
    }
    if (showProgressAlert) {
      showMessageAlert(
        title: 'Сохранено',
        message:
            'Файл сохранен $finalFileName  в папку ${GetPlatform.isIOS ? '/iPhone/Kivach Life' : '/Внутреннее хранилище/Загрузки/Kivach Life'}',
        icon:
            const Icon(Icons.download_done_rounded, color: KivachColors.green),
        mainButton:
            ['pdf', 'doc', 'docx'].contains(finalFileName.split('.').last)
                ? TextButton(
                    onPressed: () {
                      Get.to(DocumentViewPage(
                          path: '${saveDirectory?.path}/$finalFileName'));
                      Get.closeCurrentSnackbar();
                    },
                    child: const Text(
                      'Открыть в\nприложении',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: KivachColors.green),
                    ),
                  )
                : null,
      );
    }
    return '${saveDirectory.path}/$finalFileName';
  }
}
