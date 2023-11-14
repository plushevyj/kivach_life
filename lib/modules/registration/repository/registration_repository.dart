import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '/core/http/request_handler.dart';
import '/core/utils/convert_to.dart';
import '/models/profile_preview_model/profile_preview_model.dart';
import '/models/token_model/token_model.dart';

class RegistrationRepository {
  const RegistrationRepository();

  static final _dio = GetIt.I.get<Dio>();

  Future<ProfilePreview> checkRegistrationToken(
      String registrationToken) async {
    const path = '/api/register';
    final query = {'_token': registrationToken};
    final response = await handleRequest(() => _dio.get(
      path,
      queryParameters: query,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    ));
    return ConvertTo<ProfilePreview>()
        .item(response.data, ProfilePreview.fromJson);
  }

  Future<TokenModel> sendRegistrationData({
    required String registrationToken,
    required String username,
    required String email,
    required String phone,
    required String firstPassword,
    required String secondPassword,
    required bool agreeTerms,
  }) async {
    final query = {'_token': registrationToken};
    final data = {
      'registration_form[username]': username,
      'registration_form[email]': email,
      'registration_form[phone]': phone,
      'registration_form[plainPassword][first]': firstPassword,
      'registration_form[plainPassword][second]': secondPassword,
      'registration_form[agreeTerms]': agreeTerms ? 1 : 0,
    };
    final response = await _dio.post(
      '/api/register',
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      queryParameters: query,
      data: data,
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
