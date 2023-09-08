import 'package:dio/dio.dart';
import 'package:doctor/models/token_model/token_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/request_handler.dart';
import '../../../core/utils/convert_to.dart';

class ResetPasswordRepository {
  static final _dio = GetIt.I.get<Dio>();

  Future<void> checkNumber({
    required String phone,
  }) async {
    final data = {'sms_pass_reset[phone]': phone};
    try {
      final response = await Dio().post(
        '${dotenv.get('BASE_URL')}/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
    } on DioException catch (error) {
      throw error.response?.data['message'] ?? error.error;
    } catch (_) {
      rethrow;
    }
  }

  Future<TokenModel> sendCode({
    required String phone,
    required String code,
  }) async {
    final data = {'sms_pass_reset[phone]': phone, 'sms_pass_reset[code]': code};
    try {
      final response = await Dio().post(
        '${dotenv.get('BASE_URL')}/api/reset/sms',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      return ConvertTo<TokenModel>().item(response.data, TokenModel.fromJson);
    } on DioException catch (error) {
      throw error.response?.data['message'] ?? error.error;
    } catch (_) {
      rethrow;
    }
  }
}
