import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/authentication/repository/providers/token_repository_provider.dart';
import 'package:test_store_app/screens/authentication/repository/token_repository.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<AuthStates> build() async {
    return _checkState();
  }

  void updateState() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _checkState();
    });
  }

  Future<AuthStates> _checkState() async {
    var token = await ref.read(tokenRepositoryProvider).getToken();
    if (token != null && token.isNotEmpty) {
      return AuthStates.signIn;
    }
    return AuthStates.signOut;
  }
}

enum AuthStates { signIn, signOut }
