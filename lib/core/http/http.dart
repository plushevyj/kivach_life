import 'package:dio/dio.dart';
import 'package:doctor/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../modules/opening_app/controllers/configuration_of_app_controller.dart';
import '/modules/authentication/repository/login_repository.dart';
import '/modules/authentication/repository/token_repository.dart';

class DioClient {
  late final Dio _dio = Dio();
  Dio get dio => _dio;

  final _tokenRepository = const TokenRepository();
  final _loginRepository = const LoginRepository();
  final baseUrl =
      Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL;
  DioClient() {
    _dio
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = const Duration(milliseconds: 10000)
      ..options.receiveTimeout = const Duration(milliseconds: 10000)
      ..options.headers = {
        'Content-Type': 'application/json',
      }
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: _onRequestHandler,
          onError: _throwError,
        ),
      );
  }

  void _onRequestHandler(options, handler) async {
    if (options.headers['X-Auth'] == null) {
      final accessTokenFromCache = await _tokenRepository.getAccessToken();
      if (accessTokenFromCache != null) {
        addAccessTokenInHTTPClient();
        options.headers['X-Auth'] =
            'Bearer ${await _tokenRepository.getAccessToken()}';
      }
    }
    handler.next(options);
  }

  void _throwError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      final refreshTokenFromCache = await _tokenRepository.getRefreshToken();
      if (refreshTokenFromCache != null) {
        try {
          final refreshResult =
              await _loginRepository.refreshToken(refreshTokenFromCache);
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

void addAccessTokenInHTTPClient() async {
  final dio = GetIt.I.get<Dio>();
  final accessToken = await const TokenRepository().getAccessToken();
  if (accessToken != null) {
    dio.options.headers['X-Auth'] = 'Bearer $accessToken';
  } else if (dio.options.headers['X-Auth'] != null) {
    dio.options.headers.remove('X-Auth');
  }
}
