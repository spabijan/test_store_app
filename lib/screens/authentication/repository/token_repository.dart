import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_store_app/screens/authentication/repository/providers/secure_storage_provider.dart';

class TokenRepository {
  var provider = ProviderContainer();

  static const key = 'AUTH_TOKEN';
  Future<String?> getToken() async {
    final storage = provider.read(secureStorageProvider);
    String? value = await storage.read(key: key);
    return value;
  }

  Future<void> setToken(String token) async {
    FlutterSecureStorage storage = provider.read(secureStorageProvider);
    await storage.write(key: key, value: token);
  }

  Future<void> deleteToken() async {
    FlutterSecureStorage storage = provider.read(secureStorageProvider);
    await storage.delete(key: key);
  }
}
