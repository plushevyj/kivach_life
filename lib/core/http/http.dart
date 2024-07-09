import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/modules/logs/repository/logs_repository.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../modules/authentication/bloc/authentication_bloc.dart';
import '/modules/authentication/repository/login_repository.dart';
import '/modules/authentication/repository/token_repository.dart';

class DioClient {
  late final Dio _dio = Dio();
  Dio get dio => _dio;

  final _tokenRepository = const TokenRepository();
  final _loginRepository = const LoginRepository();

  DioClient({required String baseUrl}) {
    var appVersion = '';
    PackageInfo.fromPlatform()
      ..then((value) => appVersion = value.version)
      ..whenComplete(
        () => _dio
          ..options.baseUrl = baseUrl
          ..options.connectTimeout = const Duration(milliseconds: 10000)
          ..options.receiveTimeout = const Duration(milliseconds: 10000)
          ..options.headers = {
            'Content-Type': 'application/json',
            'User-Agent':
                '${FkUserAgent.userAgent ?? 'Unknown'} KivachLife/$appVersion',
          }
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: _onRequestHandler,
              onError: _throwError,
            ),
          ),
      );
  }

  void _onRequestHandler(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const LogsRepository().sendLogs(json.encode({
      'event': 'Request ${options.method} ${options.path}',
      'accessToken': options.headers['X-Auth'],
      'place': 'lib/core/http/http.dart:49',
    }));

    if (options.headers['X-Auth'] == null) {
      final accessTokenFromCache = await _tokenRepository.getAccessToken();

      const LogsRepository().sendLogs(json.encode({
        'event': 'Get access token from storage',
        'accessToken': accessTokenFromCache,
        'place': 'lib/core/http/http.dart:58',
      }));

      if (accessTokenFromCache != null) {
        addAccessTokenInHTTPClient();
        options.headers['X-Auth'] = 'Bearer $accessTokenFromCache';
      }
    }
    handler.next(options);
  }

  void _throwError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      final refreshTokenFromCache = await _tokenRepository.getRefreshToken();

      const LogsRepository().sendLogs(json.encode({
        'event': 'Get refresh token from storage',
        'refreshToken': refreshTokenFromCache,
        'place': 'lib/core/http/http.dart:78',
      }));

      if (refreshTokenFromCache != null) {
        try {
          final refreshResult =
              await _loginRepository.refreshToken(refreshTokenFromCache);

          const LogsRepository().sendLogs(json.encode({
            'event': 'Refresh token',
            'accessToken': refreshResult.token,
            'refreshResult': refreshResult.refresh_token,
            'place': 'lib/core/http/http.dart:88',
          }));

          await _tokenRepository.saveTokens(token: refreshResult);
          addAccessTokenInHTTPClient();
          final cloneReq = _dio.request(
            error.requestOptions.path,
            options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            )..headers?.addAll({'X-Auth': 'Bearer ${refreshResult.token}'}),
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
          );
          return handler.resolve(await cloneReq);
        } catch (_) {
          BlocProvider.of<AuthenticationBloc>(Get.context!).add(const LogOut());
        }
      }
    }
    handler.reject(error);
  }
}

Future<void> addAccessTokenInHTTPClient() async {
  final dio = GetIt.I.get<Dio>();
  final accessToken = await const TokenRepository().getAccessToken();

  const LogsRepository().sendLogs(json.encode({
    'event': 'Add access token in HTTP Client',
    'accessToken': accessToken,
    'place': 'lib/core/http/http.dart:109',
  }));

  if (accessToken != null) {
    dio.options.headers['X-Auth'] = 'Bearer $accessToken';
  } else if (dio.options.headers['X-Auth'] != null) {
    dio.options.headers.remove('X-Auth');
  }
}
