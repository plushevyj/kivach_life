import 'package:dio/dio.dart';
import 'package:doctor/core/http/request_handler.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/convert_to.dart';
import '../../../models/reset_phone/reset_phone_error_model/reset_password_error_model.dart';
import '../../../models/token_model/token_model.dart';

class ResetPasswordByEmailRepository {
  static final _dio = GetIt.I.get<Dio>();

  Future<void> sendEmail({
    required String email,
  }) async {
    final data = {'email_pass_reset[email]': email};
    try {
      await _dio.post(
        '/api/reset/email',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
    } on DioException catch (error) {
      logError(error);
      if (error.response?.data['message'] is String) {
        throw error.response?.data['message'];
      } else {
        final resetPasswordError = await ConvertTo<ResetPasswordErrorModel>()
            .item(error.response?.data['message'],
                ResetPasswordErrorModel.fromJson);
        if (resetPasswordError.email != null &&
            resetPasswordError.email!.isNotEmpty) {
          throw resetPasswordError.email!.first;
        }
      }
      throw constMessageError;
    } catch (_) {
      throw constMessageError;
    }
  }

  Future<TokenModel> sendCode({
    required String token,
  }) async {
    final response = await _dio.get(
      '/api/by_token',
      queryParameters: {'_token': token},
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
