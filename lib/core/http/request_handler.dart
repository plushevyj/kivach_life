// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
//
// final _logger = Logger();
//
// const constMessageError = 'Неизвестная ошибка. Повторите попытку позже.';
//
// Future<Response> handleRequest(dynamic request) async {
//   try {
//     return await request();
//   } on DioException catch (error) {
//     _logger.e(
//       'Error occur while HTTP CRUD!\n'
//       'Code ${error.response?.statusCode ?? 'null'}\n'
//       'Path: ${error.requestOptions.path}\n'
//       'Code ${error.response?.statusMessage ?? 'null'}\n'
//       'Error is: ${error.error}\n'
//       'Data is: ${error.response != null ? error.response!.data : 'NULL'}',
//     );
//     if (error.error.runtimeType == SocketException ||
//         error.error.runtimeType == HandshakeException) {
//       throw 'Ошибка соединения с сервером или отсутствует подключение к интернету';
//     }
//     throw error.response?.data['message'] ?? constMessageError;
//   } catch (error) {
//     throw constMessageError;
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

const constMessageError = 'Неизвестная ошибка. Повторите попытку позже.';

Future<Response> handleRequest(request) async {
  try {
    final response = await request() as Response;
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 400) {
      logBadResponse(response);
    } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
      logSuccess(response);
    }
    return response;
  } on DioException catch (error) {
    logError(error);
    throw error.response?.data['message'] ?? error.error;
  } catch (error) {
    rethrow;
  }
}

void logBadResponse(Response response) {
  logger.e(
    'Error occur while HTTP CRUD!\n'
    'Path: ${response.requestOptions.path}\n'
    'Full uri: ${response.realUri}\n'
    'Status code: ${response.statusCode}\n'
    'Query parameters: ${response.requestOptions.queryParameters}\n'
    'Request data: ${response.requestOptions.data}\n'
    'Request headers: ${response.requestOptions.headers}\n'
    'Response data: ${response.data}',
  );
}

void logError(DioException error) {
  logger.e(
    'Error occur while HTTP CRUD!\n'
    'Path: ${error.requestOptions.path}\n'
    'Full uri: ${error.requestOptions.uri}\n'
    'Query parameters: ${error.requestOptions.queryParameters}\n'
    'Request headers: ${error.requestOptions.headers}\n'
    'Status code: ${error.response?.statusCode}\n'
    'Request data: ${error.requestOptions.data}\n'
    'Error: ${error.error}\n'
    'Response data: ${error.response?.data}',
  );
  log(error.requestOptions.uri.toString());
}

void logSuccess(Response response) {
  logger.i(
    '🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢\n'
    'Success response\n'
    'Path: ${response.requestOptions.path}\n'
    'Full uri: ${response.realUri}\n'
    'Status code: ${response.statusCode}\n'
    'Query parameters: ${response.requestOptions.queryParameters}\n'
    'Request data: ${response.requestOptions.data}\n'
    'Request headers: ${response.requestOptions.headers}\n'
    'Response data: ${response.data}\n'
    '🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢',
  );
}
