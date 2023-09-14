import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:doctor/core/utils/convert_to.dart';
import 'package:doctor/models/profile_preview_model/profile_preview_model.dart';
import 'package:doctor/models/token_model/token_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class RegistrationRepository {
  const RegistrationRepository();

  static final _dio = GetIt.I.get<Dio>();

  Future<ProfilePreview> checkRegistrationToken(
      String registrationToken) async {
    const path = '/api/register';
    final query = {'_token': registrationToken};
    final response = await _dio.get(
      path,
      queryParameters: query,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
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
      '${dotenv.get('BASE_URL')}/api/register',
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      queryParameters: query,
      data: data,
    );
    print(response.data);
    // _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    // final response = await _dio.post(
    //   path,
    //   queryParameters: query,
    //   data: data,
    // );
    _dio.options.headers['Content-Type'] = 'application/json';
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
