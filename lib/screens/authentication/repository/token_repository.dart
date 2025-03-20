import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_store_app/screens/authentication/repository/providers/secure_storage_provider.dart';
import 'package:test_store_app/screens/authentication/utils/secure_storage_util.dart';

class TokenRepository {
  static const key = 'AUTH_TOKEN';
  Future<String?> getToken() async {
    final storage = SecureStorageUtils.getSecureStorage();
    String? value = await storage.read(key: key);
    return value;
  }

  Future<void> setToken(String token) async {
    FlutterSecureStorage storage = SecureStorageUtils.getSecureStorage();
    await storage.write(key: key, value: token);
  }

  Future<void> deleteToken() async {
    FlutterSecureStorage storage = SecureStorageUtils.getSecureStorage();
    await storage.delete(key: key);
  }
}
