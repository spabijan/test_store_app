import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/model/services/auth_service.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_repositories.dart';
import 'package:test_store_app/model/services/providers/auth_controller_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';

part 'auth_provider.g.dart';

sealed class AuthState {}

final class AuthStateLoggedOut extends AuthState {}

final class AuthStateLoggedIn extends AuthState {
  AuthStateLoggedIn({this.user, this.tokenJson});

  final User? user;
  final String? tokenJson;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  FutureOr<AuthState> build() async {
    return _refreshUserToken();
  }

  // Future<AuthState> _restoreSessionFromStorage() async {
  //   final tokenRepo = ref.watch(tokenRepositoryProvider);
  //   final token = await tokenRepo.getToken();
  //   final userRepo = ref.watch(userRepositoryProvider);
  //   final user = await userRepo.getUser();

  //   return AuthStateLoggedIn(tokenJson: token, user: user);
  // }

  void signInUser({required String email, required String password}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      var authResult = await ref
          .read(authServiceProvider)
          .signInUser(email: email, password: password);

      switch (authResult) {
        case SuccessAuthResult():
          return await _saveLocalSession(authResult);
        case FailedAuthResult():
          return AuthStateLoggedOut();
      }
    });
  }

  Future<AuthStateLoggedIn> _saveLocalSession(
      SuccessAuthResult authResult) async {
    await ref.read(tokenRepositoryProvider).setToken(authResult.tokenJson);
    await ref.read(userRepositoryProvider).setUser(authResult.userJson);
    return AuthStateLoggedIn(
        tokenJson: authResult.tokenJson,
        user: User.fromJson(json.decode(authResult.userJson)));
  }

  void deleteUser() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authToken = ref.read(loginTokenProvider)!;
      final id = ref.read(loggedUserProvider)!.id;
      await ref
          .read(authServiceProvider)
          .deleteAccount(id: id, authToken: authToken);
      return await _clearLocalSession();
    });
  }

  void logoutUser() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _clearLocalSession();
    });
  }

  Future<AuthStateLoggedOut> _clearLocalSession() async {
    await ref.read(tokenRepositoryProvider).deleteToken();
    await ref.read(userRepositoryProvider).deleteUser();
    await ref.read(cartProvider.notifier).clearCart();
    await ref.read(wishlistProvider.notifier).clearWishList();
    return AuthStateLoggedOut();
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
      return AuthStateLoggedOut();
    });
  }

  void verifyOtp({required String email, required String otp}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authServiceProvider).verifyOTP(email, otp);
      return AuthStateLoggedOut();
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
      return AuthStateLoggedIn(
          tokenJson: token, user: User.fromJson(json.decode(updatedUserJson)));
    });
  }

  Future<AuthState> _refreshUserToken() async {
    final token = await ref.read(tokenRepositoryProvider).getToken();
    if (token == null) {
      return AuthStateLoggedOut();
    }

    final refreshedAuthState =
        await ref.read(authServiceProvider).checkAuthToken(authToken: token);

    switch (refreshedAuthState) {
      case SuccessAuthResult():
        return await _saveLocalSession(refreshedAuthState);
      case FailedAuthResult():
        return await _clearLocalSession();
    }
  }
}
