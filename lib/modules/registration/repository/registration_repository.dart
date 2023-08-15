import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/request_handler.dart';

class RegistrationRepository {
  const RegistrationRepository();

  static final _http = GetIt.I.get<Dio>();

  Future<void> sendUserData({
    required String token,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    // final formQuery = {};
    // final res = await handleRequest(
    //   () => _http.post(
    //     path,
    //     queryParameters: query,
    //     data: data,
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'application/x-www-form-urlencoded',
    //       },
    //     ),
    //   ),
    // );
    final dio = Dio();
    const path = '/api/register';
    final query = {'_token': token};
    String username = 'dev-doctor';
    String password = 'u8uySN26F*4u';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final data = {
      'registration_form[username]': username,
      'registration_form[email]': email,
      'registration_form[phone]': phone,
      'registration_form[plainPassword][first]': password,
      'registration_form[plainPassword][second]': password,
      'registration_form[agreeTerms]': 1,
    };
    print(
      'profilePreview = ${await dio.post(
        'https://dev-doctors.kivach.ru$path',
        queryParameters: query,
        // data: data,
        options: Options(headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        }),
      )}',
    );
  }

}
