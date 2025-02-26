import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/providers/auth_controller_provider.dart';

part 'signin_provider.g.dart';

@riverpod
class Signin extends _$Signin {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void signinUser({required String email, required String password}) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async => await ref
        .read(authServiceProvider)
        .signInUser(email: email, password: password));

    if (key == _key) {
      state = newState;
    }
  }
}
