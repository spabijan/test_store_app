import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRepository {
  static const key = 'AUTH_TOKEN';
  Future<String?> getToken() async {
    final storage = _getStorage();
    String? value = await storage.read(key: key);
    return value;
  }

  void setToken(String token) async {
    FlutterSecureStorage storage = _getStorage();
    await storage.write(key: key, value: token);
  }

  void deleteToken() async {
    FlutterSecureStorage storage = _getStorage();
    await storage.delete(key: key);
  }

  FlutterSecureStorage _getStorage() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    return storage;
  }
}
