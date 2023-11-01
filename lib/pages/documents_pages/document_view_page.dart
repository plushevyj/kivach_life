import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:doctor/core/themes/light_theme.dart';
import 'package:document_viewer/document_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constants.dart';
import '../../modules/download_document/repository/download_document_repository.dart';
import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';

class DocumentViewPage extends StatefulWidget {
  const DocumentViewPage({
    super.key,
    this.title = 'Документ',
    required this.path,
  });

  final String title;
  final String path;

  @override
  State<DocumentViewPage> createState() => _DocumentViewPageState();
}

class _DocumentViewPageState extends State<DocumentViewPage> {
  String? pdfFlePath;

  listenForPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<String> fetchDocument() async {
    final file = File(widget.path);
    final localFilePath = widget.path;
    File localFile = File(localFilePath);
    Uint8List bytes = localFile.readAsBytesSync();
    file.writeAsBytesSync(bytes);
    return localFilePath;
  }

  void loadFile() async {
    pdfFlePath = await fetchDocument();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    setState(() {});
  }

  @override
  void initState() {
    loadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: pdfFlePath != null
            ? DocumentViewer(filePath: pdfFlePath!)
            : const Center(
                child: CircularProgressIndicator(
                  color: KivachColors.green,
                ),
              ),
      ),
    );
  }
}
