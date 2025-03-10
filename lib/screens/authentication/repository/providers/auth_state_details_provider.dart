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
        return _checkIfHasLoggedState(data.value.user, data.value.tokenJson);
      },
      error: checkPreviousState,
      loading: checkPreviousState);
}

bool checkPreviousState(AsyncValue<AuthState> previousState) {
  if (previousState.hasValue) {
    var previousValue = previousState.value!;
    return _checkIfHasLoggedState(previousValue.user, previousValue.tokenJson);
  }
  return false;
}

bool _checkIfHasLoggedState(User? user, String? token) {
  if (user != null && token != null && token.isNotEmpty) {
    return true;
  }
  return false;
}

@Riverpod(keepAlive: true)
String? loginToken(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.map(
      data: (data) => data.value.tokenJson,
      error: (error) => error.value?.tokenJson,
      loading: (loading) => loading.value?.tokenJson);
}

@Riverpod(keepAlive: true)
User? loggedUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.map(
      data: (data) => data.value.user,
      error: (error) => error.value?.user,
      loading: (loading) => loading.value?.user);
}
