import 'package:hive/hive.dart';

import '/models/token_model/token_model.dart';

class TokenRepository {
  const TokenRepository();

  Future<Box> _openStorage() async => await Hive.openBox('token');

  Future<String?> getAccessToken() async {
    final box = await _openStorage();
    return await box.get('accessToken') as String?;
  }

  Future<String?> getRefreshToken() async {
    final box = await _openStorage();
    return await box.get('refreshToken') as String?;
  }

  Future<void> saveTokens({
    required TokenModel token,
  }) async {
    final box = await _openStorage();
    box.put('accessToken', token.token);
    box.put('refreshToken', token.refresh_token);
  }

  Future<void> clearTokens() async {
    await (await _openStorage()).clear();
  }
}
