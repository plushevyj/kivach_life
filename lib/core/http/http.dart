import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '/modules/authentication/bloc/authentication_bloc.dart';
import '/modules/authentication/repository/login_repository.dart';
import '/modules/authentication/repository/token_repository.dart';
import '/modules/local_authentication/repository/local_authentication_repository.dart';

class DioClient {
  late final Dio _dio = Dio();
  Dio get dio => _dio;

  final _tokenRepository = const TokenRepository();
  final _loginRepository = const LoginRepository();
  final _localAuthenticationRepository = const LocalAuthenticationRepository();

  DioClient() {
    _dio
      ..options.baseUrl = dotenv.get('BASE_URL')
      ..options.connectTimeout = const Duration(milliseconds: 10000)
      ..options.receiveTimeout = const Duration(milliseconds: 10000)
      ..options.headers = {
        'Content-Type': 'application/json',
      }
      ..interceptors.add(InterceptorsWrapper(onError: _throwError));
  }

  void _throwError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      final refreshTokenFromCache = await _tokenRepository.getRefreshToken();
      if (refreshTokenFromCache != null) {
        try {
          final refreshResult =
              await _loginRepository.refreshToken(refreshTokenFromCache);
          _tokenRepository.saveToken(token: refreshResult);
          addAccessToken(accessToken: refreshResult.token);
          final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);
          return handler.resolve(cloneReq);
        } catch (error) {
          _tokenRepository.clearTokens();
          _localAuthenticationRepository
            ..deleteBiometricSetting()
            ..deleteLocalPassword();
          BlocProvider.of<AuthenticationBloc>(Get.context!).add(const LogOut());
        }
      }
    }

    // String? exceptionText;
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

void addAccessToken({required String accessToken}) {
  GetIt.I.get<Dio>().options.headers['X-Auth'] = 'Bearer $accessToken';
}
