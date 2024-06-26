import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../models/reset_phone/reset_phone_error_model/reset_password_error_model.dart';
import '/models/token_model/token_model.dart';
import '../../../core/http/request_handler.dart';
import '../../../core/utils/convert_to.dart';

class ResetPasswordBySmsRepository {
  static final _dio = GetIt.I.get<Dio>();

  Future<int?> checkNumber({
    required String phone,
  }) async {
    final data = {'sms_pass_reset[phone]': phone};
    try {
      await _dio.post(
        '/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
    } on DioException catch (error) {
      logError(error);
      final resetPasswordError = await ConvertTo<ResetPasswordErrorModel>()
          .item(error.response?.data['message'],
              ResetPasswordErrorModel.fromJson);
      if (resetPasswordError.phone != null &&
          resetPasswordError.phone!.isNotEmpty) {
        throw resetPasswordError.phone!.first;
      } else if (resetPasswordError.remainingTime != null) {
        return resetPasswordError.remainingTime!;
      }
      throw 'Неизвестная ошибка';
    } catch (_) {
      rethrow;
    }
    return null;
  }

  Future<TokenModel> sendCode({
    required String phone,
    required String code,
  }) async {
    final data = {'sms_pass_reset[phone]': phone, 'sms_pass_reset[code]': code};
    final response = await handleRequest(
      () => _dio.post(
        '/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      ),
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
