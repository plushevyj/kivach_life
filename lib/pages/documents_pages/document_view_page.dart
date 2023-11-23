import 'dart:io';
import 'dart:typed_data';

import 'package:doctor/modules/identity_proof/ui/identity_proof_ui.dart';
import 'package:document_viewer/document_viewer.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '/core/themes/light_theme.dart';

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
  String? filePath;

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
    filePath = await fetchDocument();
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
        actions: [
          IconButton(
            onPressed: () async {
              if (await identityProof()) {
                await Share.shareXFiles([XFile(widget.path)]);
              }
            },
            icon: const Icon(
              Icons.share_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: filePath != null
            ? DocumentViewer(filePath: filePath!)
            : const Center(
                child: CircularProgressIndicator(
                  color: KivachColors.green,
                ),
              ),
      ),
    );
  }
}
