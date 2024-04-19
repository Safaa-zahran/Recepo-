import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static SecureStorageService? _instance;
  SecureStorageService._init();
  static SecureStorageService get instance =>
      _instance ??= SecureStorageService._init();

  static FlutterSecureStorage? _secureStorage;
  static Future<FlutterSecureStorage> get secureStorage async =>
      _secureStorage ??= const FlutterSecureStorage();

  Future<void> writeString({required String key, required String value}) async {
    final storage = await secureStorage;
    return await storage.write(key: key, value: value);
  }

  Future<String?> readString({required String key}) async {
    final storage = await secureStorage;
    return await storage.read(key: key);
  }

  Future<void> writeBool({required String key, required bool value}) async {
    final storage = await secureStorage;
    return await storage.write(key: key, value: value.toString());
  }

  Future<bool?> readBool({required String key}) async {
    final storage = await secureStorage;
    final value = await storage.read(key: key);
    return value == null ? null : value == 'true';
  }

  Future<void> deleteAllData() async {
    final storage = await secureStorage;
    return await storage.deleteAll();
  }
}
