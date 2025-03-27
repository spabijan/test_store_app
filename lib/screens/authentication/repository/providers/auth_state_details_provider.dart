import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';

part 'auth_state_details_provider.g.dart';

@Riverpod(keepAlive: true)
bool isLogin(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.map(
      data: (data) {
        var authState = data.value;
        return switch (authState) {
          AuthStateLoggedOut() => false,
          AuthStateLoggedIn() =>
            _checkIfHasLoggedState(authState.user, authState.tokenJson)
        };
      },
      error: checkPreviousState,
      loading: checkPreviousState);
}

bool checkPreviousState(AsyncValue<AuthState> previousState) {
  if (previousState.hasValue) {
    var previousValue = previousState.value!;
    return switch (previousValue) {
      AuthStateLoggedOut() => false,
      AuthStateLoggedIn() =>
        _checkIfHasLoggedState(previousValue.user, previousValue.tokenJson),
    };
  }
  return false;
}

@Riverpod(keepAlive: true)
String? loginToken(Ref ref) {
  final authState = ref.watch(authProvider);
  return _extractTokenJson(authState.value);
}

@Riverpod(keepAlive: true)
User? loggedUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return _extractUser(authState.value);
}

bool _checkIfHasLoggedState(User? user, String? token) {
  if (user != null && token != null && token.isNotEmpty) {
    return true;
  }
  return false;
}

User? _extractUser(AuthState? authState) {
  return switch (authState) {
    AuthStateLoggedOut() => null,
    AuthStateLoggedIn() => authState.user,
    null => null,
  };
}

String? _extractTokenJson(AuthState? authState) {
  return switch (authState) {
    AuthStateLoggedOut() => null,
    AuthStateLoggedIn() => authState.tokenJson,
    null => null,
  };
}
