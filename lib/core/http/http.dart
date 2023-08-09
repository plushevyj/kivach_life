import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class Http {
  const Http();

  Dio createClient() => Dio()
    ..options.baseUrl = 'https://dev-doctors.kivach.ru/'
    ..options.connectTimeout = const Duration(microseconds: 10000)
    ..options.receiveTimeout = const Duration(microseconds: 10000)
    ..options.headers = {'Authorization': _getBasicAuth()}
    ..interceptors.add(InterceptorsWrapper(onError: _throwError));

  static void _throwError(DioException error, ErrorInterceptorHandler handler) {
    String? exceptionText;
    // Todo describe reaction on all standard Exceptions
    if (error.response != null) {
      exceptionText = error.response?.data['detail'].toString();
    } else {
      switch (error.error.runtimeType) {
        case SocketException:
          error.error.toString().contains('Failed host lookup')
              ? exceptionText = 'Ошибка подключения к серверу'
              : exceptionText = 'Отсутствует подключение к интернету';
          break;
        default:
          exceptionText = 'Возникло исключение:\n${error.error}';
      }
    }
    if (exceptionText != null) throw exceptionText;
  }

  String _getBasicAuth() {
    String username = 'dev-doctor';
    String password = 'u8uySN26F*4u';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    return basicAuth;
  }
}
