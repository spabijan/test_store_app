import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/authentication/repository/token_repository.dart';

part 'token_repository_provider.g.dart';

@riverpod
TokenRepository tokenRepository(Ref ref) {
  return TokenRepository();
}
