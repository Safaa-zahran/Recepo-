import 'package:dio/dio.dart';
import '../../secure_storage/secure_storage_keys.dart.dart';
import '../../secure_storage/secure_storage_service.dart';

const authHeader = {'Authorization': ''};

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey(authHeader.keys.first)) {
      final token = await SecureStorageService.instance
          .readString(key: SecureStorageKeys.token);
      options.headers[authHeader.keys.first] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }
}
