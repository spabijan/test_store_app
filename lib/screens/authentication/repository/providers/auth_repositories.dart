import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/authentication/repository/token_repository.dart';
import 'package:test_store_app/screens/authentication/repository/user_repository.dart';

part 'auth_repositories.g.dart';

@riverpod
TokenRepository tokenRepository(Ref ref) {
  return TokenRepository();
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository();
}
