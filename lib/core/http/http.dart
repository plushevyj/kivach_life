import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:doctor/models/token_model/token_model.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../modules/authentication/bloc/authentication_bloc.dart';
import '../../modules/authentication/repository/login_repository.dart';
import '../../modules/authentication/repository/token_repository.dart';
import '../utils/convert_to.dart';

class DioClient {
  late final Dio _dio = Dio();
  Dio get dio => _dio;

  final _tokenRepository = const TokenRepository();
  final _loginRepository = const LoginRepository();

  DioClient() {
    _dio
      ..options.baseUrl = 'https://dev-doctors.kivach.ru/'
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..options.headers = {
        'Authorization': basicAuth(),
        'Content-Type': 'application/json',
      }
      ..interceptors.add(InterceptorsWrapper(onError: _throwError));
  }

  void _throwError(DioException error, ErrorInterceptorHandler handler) async {
    String? exceptionText;
    if (error.response?.statusCode == 401) {
      print('refreshTokenFromCache');
      final refreshTokenFromCache =
          await handleRequest(() => _tokenRepository.getRefreshToken())
              as String?;
      print('refreshTokenFromCache = $refreshTokenFromCache');
      if (refreshTokenFromCache != null) {
        final refreshResult = await handleRequest(
            () => _loginRepository.refreshToken(refreshTokenFromCache));
        final token = await ConvertTo<TokenModel>()
            .item(refreshResult.data, TokenModel.fromJson);
        _tokenRepository.saveTokens(
            accessToken: token.token, refreshTokens: token.refresh_token);
        final opts = Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        final cloneReq = await dio.request(error.requestOptions.path,
            options: opts,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
        return handler.resolve(cloneReq);
      }
    }

    // if (error.response != null) {
    //   exceptionText = error.response?.data['detail'].toString();
    // } else {
    //   switch (error.error.runtimeType) {
    //     case SocketException:
    //       error.error.toString().contains('Failed host lookup')
    //           ? exceptionText = 'Ошибка подключения к серверу'
    //           : exceptionText = 'Отсутствует подключение к интернету';
    //       break;
    //     default:
    //       exceptionText = 'Возникло исключение:\n${error.error}';
    //   }
    // }
    // if (exceptionText != null) throw exceptionText;
  }
}

String basicAuth() {
  String username = 'dev-doctor';
  String password = 'u8uySN26F*4u';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  return basicAuth;
}
