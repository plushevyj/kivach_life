import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'token_repository.dart';

class TokenRepository {
  const TokenRepository();

  Future<String?> getToken() async {
    final box = await _openStorage();
    return box.get('token') as String?;
  }

  void addToken(String token) {
    GetIt.I.get<Dio>().options.headers['Authorization'] = 'Bearer $token';
  }

  Future<void> saveToken(String token) async {
    final box = await _openStorage();
    box.put('token', token);
  }

  Future<void> clearToken() async => await (await _openStorage()).clear();

  Future<Box> _openStorage() async => await Hive.openBox('token');
}
