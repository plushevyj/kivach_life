import 'package:dio/dio.dart';
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
      Get.find<ConfigurationOfAppController>().configuration.value.BASE_URL;
  DioClient() {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 10000)
      ..options.receiveTimeout = const Duration(milliseconds: 10000)
      ..options.headers = {
        'Content-Type': 'application/json',
      }
      ..interceptors.add(
        InterceptorsWrapper(
          // onRequest: (options, handler) {
          //   print('\n\n\n');
          //   print('=========REQUEST=========');
          //   print(options.path);
          //   print('data = ${options.data}');
          //   print('headers = ${options.headers}');
          //   print('\n\n\n');
          //   if (options.path == '/api/push-token/set')
          //     showSuccessAlert(
          //         '${options.path}\n data = ${options.data} \n headers = ${options.headers}',
          //         duration: Duration(seconds: 60));
          //   handler.next(options);
          // },
          onError: _throwError,
        ),
      );
  }

  void _throwError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      final refreshTokenFromCache = await _tokenRepository.getRefreshToken();
      if (refreshTokenFromCache != null) {
        try {
          final refreshResult =
              await _loginRepository.refreshToken(refreshTokenFromCache);
          await _tokenRepository.saveToken(token: refreshResult);
          addAccessToken(accessToken: refreshResult.token);
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
        } catch (_) {}
      }
    }
    handler.reject(error);
  }
}

void addAccessToken({required String accessToken}) {
  GetIt.I.get<Dio>().options.headers['X-Auth'] = 'Bearer $accessToken';
}
