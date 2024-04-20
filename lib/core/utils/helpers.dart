import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Helpers {
  static void debugDioError(DioError error) {
    if (kDebugMode) {
      log(error.response!.statusCode.toString());
      log(error.response!.data.toString());
    }
  }
}
