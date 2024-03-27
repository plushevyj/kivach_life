import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../models/profile/profile_model.dart';
import '../../opening_app/controllers/configuration_of_app_controller.dart';
import '/models/token_model/token_model.dart';
import '/core/http/request_handler.dart';
import '/core/utils/convert_to.dart';
import 'token_repository.dart';

class LoginRepository {
  const LoginRepository();

  static final _dio = GetIt.I.get<Dio>();
  final _tokenRepository = const TokenRepository();

  Future<TokenModel> logIn({
    required String username,
    required String password,
  }) async {
    final data = {'username': username, 'password': password};
    final response =
        await handleRequest(() => _dio.post('/api/login', data: data));
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }

  // Используется совместно с авторизаией
  Future<Profile> getProfile() async {
    final res = await handleRequest(() => _dio.get('/api/profile'));
    return ConvertTo<Profile>().item(res.data, Profile.fromJson);
  }

  Future<TokenModel> refreshToken(String refreshToken) async {
    final path =
        '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}/api/token/refresh';
    final query = {
      'refresh_token': refreshToken,
    };
    final response = await handleRequest(
      () => Dio().post(
        path,
        queryParameters: query,
      ),
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }

  Future<void> logOut() async {
    final refreshToken = await _tokenRepository.getRefreshToken();
    await handleRequest(
      () => Dio().get(
        '${Get.find<ConfigurationOfAppController>().configuration.value?.BASE_URL}/api/token/invalidate',
        queryParameters: {'refresh_token': refreshToken},
      ),
    );
  }
}
