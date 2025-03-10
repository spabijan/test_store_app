import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';

part 'auth_state_details_provider.g.dart';

@Riverpod(keepAlive: true)
bool isLogin(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
      data: (data) {
        if (data.user != null &&
            data.tokenJson != null &&
            data.tokenJson!.isNotEmpty) {
          return true;
        }
        return false;
      },
      orElse: () => false);
}

@Riverpod(keepAlive: true)
String? loginToken(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
      data: (data) => data.tokenJson, orElse: () => null);
}

@Riverpod(keepAlive: true)
User? loggedUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(data: (data) => data.user, orElse: () => null);
}
