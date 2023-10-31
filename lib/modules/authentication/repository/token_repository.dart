import 'package:shared_preferences/shared_preferences.dart';

import '/models/token_model/token_model.dart';

class _TokensKeyStore {
  _TokensKeyStore._();

  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
}

class TokenRepository {
  const TokenRepository();

  Future<String?> getAccessToken() async {
    return (await SharedPreferences.getInstance())
        .getString(_TokensKeyStore.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return (await SharedPreferences.getInstance())
        .getString(_TokensKeyStore.refreshToken);
  }

  Future<void> saveTokens({
    required TokenModel token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs
      ..setString(_TokensKeyStore.accessToken, token.token)
      ..setString(_TokensKeyStore.refreshToken, token.refresh_token);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs
      ..remove(_TokensKeyStore.accessToken)
      ..remove(_TokensKeyStore.refreshToken);
  }
}
