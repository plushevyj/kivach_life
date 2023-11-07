import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

const maxLengthLocalPassword = 4;

final documentsDirectory = (() async => GetPlatform.isAndroid
    ? Directory('/storage/emulated/0/Download/Kivach Life')
    : await getApplicationDocumentsDirectory())();
