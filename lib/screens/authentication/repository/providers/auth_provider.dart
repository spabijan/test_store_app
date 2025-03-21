import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_repositories.dart';
import 'package:test_store_app/model/services/providers/auth_controller_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';

part 'auth_provider.g.dart';

final class AuthState {
  AuthState({this.user, this.tokenJson});

  final User? user;
  final String? tokenJson;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  FutureOr<AuthState> build() async {
    return _restoreSessionFromStorage();
  }

  Future<AuthState> _restoreSessionFromStorage() async {
    final tokenRepo = ref.watch(tokenRepositoryProvider);
    final token = await tokenRepo.getToken();
    final userRepo = ref.watch(userRepositoryProvider);
    final user = await userRepo.getUser();

    return AuthState(tokenJson: token, user: user);
  }

  void signInUser({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      var authResult = await ref
          .read(authServiceProvider)
          .signInUser(email: email, password: password);

      await ref.read(tokenRepositoryProvider).setToken(authResult.tokenJson);
      await ref.read(userRepositoryProvider).setUser(authResult.userJson);

      return AuthState(
          tokenJson: authResult.tokenJson,
          user: User.fromJson(json.decode(authResult.userJson)));
    });
  }

  void logoutUser() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(tokenRepositoryProvider).deleteToken();
      await ref.read(userRepositoryProvider).deleteUser();
      await ref.read(cartProvider.notifier).clearCart();
      await ref.read(wishlistProvider.notifier).clearWishList();
      return AuthState(tokenJson: null, user: null);
    });
  }

  void signupUser(
      {required String fullName,
      required String email,
      required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(authServiceProvider)
          .signupUser(fullName: fullName, email: email, password: password);
      return AuthState(tokenJson: null, user: null);
    });
  }

  void updateAddressData(
      {required String id,
      required String city,
      required String state,
      required String locality}) async {
    this.state = const AsyncLoading();
    this.state = await AsyncValue.guard(() async {
      final updatedUserJson = await ref
          .read(authServiceProvider)
          .updateUserAddress(
              id: id, city: city, state: state, locality: locality);

      await ref.read(userRepositoryProvider).setUser(updatedUserJson);
      final tokenRepository = ref.watch(tokenRepositoryProvider);

      final token = await tokenRepository.getToken();

      return AuthState(
          tokenJson: token, user: User.fromJson(json.decode(updatedUserJson)));
    });
  }
}
