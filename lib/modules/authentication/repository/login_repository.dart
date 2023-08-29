import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../../../models/profile/profile_model.dart';
import '/models/token_model/token_model.dart';
import '/core/http/http.dart';
import '/core/http/request_handler.dart';
import '/core/utils/convert_to.dart';

class LoginRepository {
  const LoginRepository();

  static final _dio = GetIt.I.get<Dio>();

  Future<TokenModel> logIn({
    required String username,
    required String password,
  }) async {
    final data = {'username': username, 'password': password};
    final response =
        await handleRequest(() => _dio.post('/api/login', data: data));
    final result = TokenModel.fromJson(response.data);
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }

  Future<Profile> logInByToken() async {
    try {
      final res = await handleRequest(() => _dio.get('/api/profile'));
      return ConvertTo<Profile>().item(res.data, Profile.fromJson);
    } catch (error) {
      rethrow;
    }
  }

  Future<TokenModel> refreshToken(String refreshToken) async {
    print(refreshToken);
    final path = '${dotenv.get('BASE_URL')}/api/token/refresh';
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
}
