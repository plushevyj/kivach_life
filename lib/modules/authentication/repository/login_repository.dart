import 'package:dio/dio.dart';

import '../../../models/profile/profile_model.dart';
import '/models/token_model/token_model.dart';
import '/core/http/http.dart';
import '/core/http/request_handler.dart';
import '/core/utils/convert_to.dart';

class LoginRepository {
  const LoginRepository();

  // static final _http = GetIt.I.get<Dio>();

  // Future<Account> logIn({
  //   required String username,
  //   required String password,
  // }) async {
  //   const path = '/parse/parse/login';
  //   final data = {
  //     'username': username,
  //     'password': password,
  //   };
  //
  //   final data = kDebugMode ? dev['test'] : prod;
  //
  //   final res = await handleRequest(() => _http.post(path, data: data));
  //   return ConvertTo<PlayerAccount>().item(res.data, PlayerAccount.fromJson);
  // }
  //
  // Future<PlayerAccount> loginByToken() async {
  //   final res = await handleRequest(() => _http.get('/api/v1/auth/me'));
  //   return ConvertTo<PlayerAccount>().item(res.data, PlayerAccount.fromJson);
  // }

  /////////////////////////////////////////////////////////////////////////////

  Future<TokenModel> logIn({
    required String username,
    required String password,
  }) async {
    final http = Dio();
    http.options
      ..baseUrl = 'https://dev-doctors.kivach.ru/'
      ..headers = ({
        'Authorization': basicAuth(),
        'Content-Type': 'application/json',
      });
    final data = {"username": username, "password": password};
    final res = await handleRequest(() => http.post('/api/login', data: data));
    return ConvertTo<TokenModel>().item(res.data, TokenModel.fromJson);
  }

  Future<TokenModel> refresh({required String refreshToken}) async {
    final http = Dio();
    http.options
      ..baseUrl = 'https://dev-doctors.kivach.ru/'
      ..headers = ({
        'Authorization': basicAuth(),
        'Content-Type': 'application/json',
      });
    final query = {'refresh_token': refreshToken};
    final res = await handleRequest(() => http.post(
          '/api/token/refresh',
          queryParameters: query,
        ));
    return ConvertTo<TokenModel>().item(res.data, TokenModel.fromJson);
  }

  Future<Profile> logInByToken() async {
    final http = Dio();
    http.options
      ..baseUrl = 'https://dev-doctors.kivach.ru/'
      ..headers = ({
        'Authorization': basicAuth(),
        'Content-Type': 'application/json',
      });
    final res = await handleRequest(() => http.post('/api/profile'));
    return ConvertTo<Profile>().item(res.data, Profile.fromJson);
  }
}
