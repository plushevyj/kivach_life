import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor/core/utils/convert_to.dart';
import 'package:doctor/models/profile_preview_model/profile_preview_model.dart';
import 'package:doctor/models/token_model/token_model.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/request_handler.dart';

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
    required String password,
  }) async {
    const path = '/api/register';
    final query = {'_token': registrationToken};
    final data = {
      'registration_form[username]': username,
      'registration_form[email]': email,
      'registration_form[phone]': phone,
      'registration_form[plainPassword][first]': password,
      'registration_form[plainPassword][second]': password,
      'registration_form[agreeTerms]': 1,
    };
    final response = await _dio.post(
      path,
      queryParameters: query,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }),
    );
    _dio.options.headers.addAll(
      {'Content-Type': 'application/json'},
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
