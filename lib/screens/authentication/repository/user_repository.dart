import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_store_app/model/models/user/user.dart';

class UserRepository {
  static const key = 'USER';
  Future<User?> getToken() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String? value = await storage.read(key: key);
    return value != null ? User.fromJson(json.decode(value)) : null;
  }

  void setUser(String userJson) async {
    FlutterSecureStorage storage = _getStorage();
    await storage.write(key: key, value: userJson);
  }

  Future<void> deleteUser() async {
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
