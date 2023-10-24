import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:doctor/core/themes/light_theme.dart';
import 'package:document_viewer/document_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';

class DocumentViewPage extends StatefulWidget {
  const DocumentViewPage({
    super.key,
    required this.title,
    required this.route,
  });

  final String title;
  final String route;

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

  Future<String> getPersonalDataPolitics() async {
    final directory = await getTemporaryDirectory();
    await Dio().download(
      '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}${widget.route}',
      '${directory.path}${widget.route}',
    );
    final file = File('${directory.path}${widget.route}');
    final localFilePath = '${directory.path}${widget.route}';
    File localFile = File(localFilePath);
    Uint8List bytes = localFile.readAsBytesSync();
    file.writeAsBytesSync(bytes);
    return localFilePath;
  }

  void loadFile() async {
    pdfFlePath = await getPersonalDataPolitics();
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
