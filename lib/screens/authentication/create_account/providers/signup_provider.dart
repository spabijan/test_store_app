import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/providers/auth_controller_provider.dart';

part 'signup_provider.g.dart';

@riverpod
class Signup extends _$Signup {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void signupUser(
      {required String fullName,
      required String email,
      required String password}) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      /*final authResult = */ await ref
          .read(authServiceProvider)
          .signupUser(fullName: fullName, email: email, password: password);
      // ref.read(tokenRepositoryProvider).setToken(authResult.tokenJson);
      // ref.read(userRepositoryProvider).setUser(authResult.userJson);
    });

    if (key == _key) {
      state = newState;
    }
  }
}
