import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/api_interceptor.dart';

class ApiClient {
  // Singleton
  static ApiClient? _instance;
  static ApiClient get instance => _instance ??= ApiClient._init();
  ApiClient._init();

  // Dio Object & Configuration
  final BaseOptions _options = BaseOptions(
    baseUrl: 'https://test.kakas.app/',
    validateStatus: (status) => status == 200,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  Dio? _dio;
  Dio get dio => _dio ??= Dio(_options)
    ..interceptors.addAll([
      ApiInterceptors(),
      PrettyDioLogger(
        responseBody: false,
      ),
    ]);
}
