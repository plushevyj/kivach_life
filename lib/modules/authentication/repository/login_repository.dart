import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/models/token_model/token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/http.dart';
import '../../../core/http/request_handler.dart';
import '../../../core/utils/convert_to.dart';

// import '../../../core/utils/convert_to.dart';
// import '../../../core/http/request_handler.dart';
// import '../../account/model/player_account.dart';

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
    final data = {"username": "flycode", "password": "flycode"};
    final res = await handleRequest(() => http.post('/api/login', data: data));
    return ConvertTo<TokenModel>().item(res.data, TokenModel.fromJson);
  }
}
