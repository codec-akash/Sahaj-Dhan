import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true));

  static final SecureStorage _instance = SecureStorage._();

  SecureStorage._();

  factory SecureStorage.getInstance() => _instance;

  Future<String?> getAccessToken() async {
    var token = await _flutterSecureStorage.read(key: "access_token");
    return token;
  }

  Future<String?> getRefreshToken() async {
    var token = await _flutterSecureStorage.read(key: "refresh_token");
    return token;
  }

  Future<void> writeAccessToken({required String token}) async {
    await _flutterSecureStorage.write(key: "access_token", value: token);
  }

  Future<void> writeRefreshToken({required String token}) async {
    await _flutterSecureStorage.write(key: "refresh_token", value: token);
  }

  Future<void> deleteAll() async {
    await _flutterSecureStorage.deleteAll();
  }
}
