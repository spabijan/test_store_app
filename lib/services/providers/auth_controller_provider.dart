import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/auth_service.dart';

part 'auth_controller_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}
