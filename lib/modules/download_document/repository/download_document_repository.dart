import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/request_handler.dart';

class DownloadDocumentRepository {
  static final _dio = GetIt.I.get<Dio>();

  Future<Response> download(String url, String savedPath) async {
    return await handleRequest(() => _dio.download(url, savedPath));
  }
}
