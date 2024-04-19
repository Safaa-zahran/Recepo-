import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../utils/helpers.dart';
import '../api_client.dart';
import '../interceptors/api_interceptor.dart';
import 'exceptions/api_exception.dart';

class UserApi {
  static Future<Map<String, dynamic>> register({
    required password,
    required userName
  }) async {
    try {
      final response = await ApiClient.instance.dio.post('api/auth/register', data: {
        "username": userName,
        "password": password
      });

      return response.data;
    } on DioError catch (error) {
      Helpers.debugDioError(error);
      rethrow;
      // if (error.response!.statusCode == 422) {
      //   final errors = response!.data['error'] as List;
      //   throw ApiException(errors.join('\n'));
      // } else {
      //   rethrow;
      // }
    } on ApiException catch (_) {
      rethrow;
    } catch (error) {
      throw LocaleKeys.genericErrorMessage.tr();
    }
  }

  static Future<Map<String, dynamic>> login({
    required String? password,
    required String? userName,
  }) async {
    try {
      final response = await ApiClient.instance.dio.post('api/auth/login', data: {
        "username": userName,
        "password": password
      });

      return response.data;
    } on DioError catch (error) {
      Helpers.debugDioError(error);

      if (error.response!.statusCode == 422) {
        final errors = error.response!.data['error'] as List;
        throw ApiException(errors.join('\n'));
      } else {
        rethrow;
      }
    } on ApiException catch (_) {
      rethrow;
    } catch (error) {
      throw LocaleKeys.genericErrorMessage.tr();
    }
  }
}
