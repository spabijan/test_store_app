import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';

part 'user_provider.g.dart';

@riverpod
class UserState extends _$UserState {
  @override
  User? build() {
    return const User(fullName: '', email: '', password: '');
  }

  void setCurrentUser(String userJson) =>
      state = User.fromJson(json.decode(userJson));

  void logoutCurrentuser() => state = null;
}
