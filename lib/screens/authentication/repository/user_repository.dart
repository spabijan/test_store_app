import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/screens/authentication/repository/providers/secure_storage_provider.dart';

class UserRepository {
  var provider = ProviderContainer();
  static const key = 'USER';
  Future<User?> getUser() async {
    final storage = provider.read(secureStorageProvider);
    String? value = await storage.read(key: key);
    return value != null ? User.fromJson(json.decode(value)) : null;
  }

  Future<void> setUser(String userJson) async {
    FlutterSecureStorage storage = provider.read(secureStorageProvider);
    await storage.write(key: key, value: userJson);
  }

  Future<void> deleteUser() async {
    FlutterSecureStorage storage = provider.read(secureStorageProvider);
    await storage.delete(key: key);
  }
}
