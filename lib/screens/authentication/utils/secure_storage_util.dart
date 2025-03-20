import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorageUtils {
  SecureStorageUtils._();
  static FlutterSecureStorage getSecureStorage() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    return storage;
  }
}
