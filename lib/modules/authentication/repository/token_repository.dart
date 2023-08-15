import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'token_repository.dart';

class TokenRepository {
  const TokenRepository();

  Future<Box> _openStorage() async => await Hive.openBox('token');

  Future<String?> getAccessToken() async {
    final box = await _openStorage();
    return box.get('accessToken') as String?;
  }

  Future<String?> getRefreshToken() async {
    final box = await _openStorage();
    return box.get('accessToken') as String?;
  }

  void addAccessToken(String accessToken) {
    GetIt.I.get<Dio>().options.headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshTokens,
  }) async {
    final box = await _openStorage();
    box.put('accessToken', accessToken);
    box.put('refreshToken', accessToken);
  }

  Future<void> clearTokens() async {
    await (await _openStorage()).clear();
  }
}
