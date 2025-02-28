import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/user_provider.dart';

part 'logout_provider.g.dart';

@riverpod
class Logout extends _$Logout {
  @override
  void build() {
    return;
  }

  void logout() {
    ref.watch(authStateProvider.notifier).signOut();
    ref.watch(userStateProvider.notifier).logoutCurrentuser();
  }
}
