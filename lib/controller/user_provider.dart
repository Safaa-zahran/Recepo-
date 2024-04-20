import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../core/services/http/apis/user_api.dart';
import '../core/services/secure_storage/secure_storage_keys.dart.dart';
import '../core/services/secure_storage/secure_storage_service.dart';

class UserProvider with ChangeNotifier {
  Future<void> login(
      {required String userName, required String password}) async {
    try {
      final response =
          await UserApi.login(userName: userName, password: password);
      final token = response['token'];

      await Future.wait([
        SecureStorageService.instance.writeString(
          key: SecureStorageKeys.token,
          value: token,
        ),
      ]);
      notifyListeners();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> register({required password, required userName}) async {
    try {
      final response =
          await UserApi.register(password: password, userName: userName);
      final token = response['token'];
      await Future.wait([
        SecureStorageService.instance.writeString(
          key: SecureStorageKeys.token,
          value: token,
        ),
      ]);
      notifyListeners();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
