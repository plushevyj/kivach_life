import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime_dart/mime_dart.dart';

import '/core/utils/constants.dart';
import '/core/themes/light_theme.dart';
import '/pages/documents_pages/document_view_page.dart';
import '/widgets/alerts.dart';
import '../repository/download_document_repository.dart';

class DownloadDocumentHandler {
  final _downloadDocumentRepository = DownloadDocumentRepository();

  Future<String?> downloadFile({
    required Uri url,
    Directory? saveDirectory,
    bool showProgressAlert = false,
  }) async {
    saveDirectory ??= await documentsDirectory;
    if (!await saveDirectory.exists()) {
      saveDirectory.create();
    }
    final downloadingFileName = url.path.split('/').last;
    var finalFileName = downloadingFileName;
    try {
      if (showProgressAlert) {
        showMessageAlert(
          title: 'Идёт загрузка',
          message: GetPlatform.isIOS
              ? 'Файл загружается в папку "/Device/Kivach Life".'
              : 'Все загруженные файлы вы можете просмотреть в "Настройках" в разделе "Загрузки".',
          icon: const Icon(Icons.download_rounded, color: KivachColors.green),
          duration: const Duration(seconds: 2),
        );
      }
      final response = await _downloadDocumentRepository.download(
          url.toString(), '${saveDirectory.path}/$downloadingFileName');
      if (!downloadingFileName.contains('.')) {
        final disposition = response.headers.map['content-disposition'];
        if (disposition != null) {
          final dispositionTokens = disposition.first.split(';');
          final dispositionFileName = dispositionTokens.firstWhereOrNull(
              (token) => token.contains(RegExp(r'filename=| filename=')));
          if (dispositionFileName != null) {
            finalFileName = dispositionFileName.replaceAll(
                RegExp(r'filename=| filename=|"'), '');
            finalFileName = utf8.decode(finalFileName.codeUnits);
          }
        } else {
          final type = Mime.getExtensionsFromType(
              response.headers.value('content-type')!);
          if (type != null && type.isNotEmpty) {
            finalFileName = '$downloadingFileName.${type.first}';
          }
        }
        if (finalFileName != downloadingFileName) {
          File('${saveDirectory.path}/$downloadingFileName')
              .rename('${saveDirectory.path}/$finalFileName');
        }
      }
      if (showProgressAlert) {
        showMessageAlert(
          title: 'Сохранено',
          message: GetPlatform.isIOS
              ? 'Файл $finalFileName сохранен в папку  "/Device/Kivach Life"'
              : 'Файл $finalFileName сохранен. Вы можете его просмотреть в "Настройках" в разделе "Загрузки"',
          icon: const Icon(Icons.download_done_rounded,
              color: KivachColors.green),
          mainButton:
              ['pdf', 'doc', 'docx'].contains(finalFileName.split('.').last)
                  ? TextButton(
                      onPressed: () {
                        Get.to(() => DocumentViewPage(
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
    } catch (error) {
      showErrorAlert('Повторите попытку позже.');
    }
    return '${saveDirectory.path}/$finalFileName';
  }
}
