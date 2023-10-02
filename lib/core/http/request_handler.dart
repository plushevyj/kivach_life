import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

Future<Response> handleRequest(dynamic request) async {
  try {
    return await request();
  } on DioException catch (error) {
    _logger.e(
      'Error occur while HTTP CRUD!\n'
      'Code ${error.response?.statusCode ?? 'null'}\n'
      'Path: ${error.requestOptions.path}\n'
      'Code ${error.response?.statusMessage ?? 'null'}\n'
      'Error is: ${error.error}\n'
      'Data is: ${error.response != null ? error.response!.data : 'NULL'}',
    );
    if (error.error.runtimeType == SocketException) {
      throw 'Ошибка соединения с сервером или отсутствует подключение к интернету';
    }
    throw error.response?.data['message'] ?? error.error;
  } catch (error) {
    rethrow;
  }
}
