import 'package:get/get_utils/src/platform/platform.dart';
import 'package:path_provider/path_provider.dart';

const maxLengthLocalPassword = 4;

// final documentsDirectory = (() async => GetPlatform.isAndroid
//     ? Directory('/storage/emulated/0/Download/Kivach Life')
//     : await getApplicationDocumentsDirectory())();

final documentsDirectory = (() async => GetPlatform.isAndroid
    ? await getApplicationDocumentsDirectory()
    : await getApplicationDocumentsDirectory())();
