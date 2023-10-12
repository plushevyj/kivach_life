import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../models/reset_phone/reset_phone_error_model/reset_password_error_model.dart';
import '../../opening_app/controllers/configuration_of_app_controller.dart';
import '/models/token_model/token_model.dart';
import '../../../core/http/request_handler.dart';
import '../../../core/utils/convert_to.dart';

class ResetPasswordRepository {
  static final _dio = GetIt.I.get<Dio>();
  final baseUrl = Get.find<ConfigurationOfAppController>().configuration.value.BASE_URL;

  Future<int?> checkNumber({
    required String phone,
  }) async {

    final data = {'sms_pass_reset[phone]': phone};
    try {
      await _dio.post(
        '$baseUrl/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
    } on DioException catch (error) {
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
        '$baseUrl/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      ),
    );
    return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
  }
}
