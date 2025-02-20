import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {required String fullName,
      required String email,
      required String password,
      @JsonKey(name: '_id') @Default('') String id,
      @Default('') String state,
      @Default('') String city,
      @Default('') String locality,
      @Default('') String token}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
