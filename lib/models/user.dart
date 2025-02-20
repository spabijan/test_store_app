import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {@JsonKey(name: 'name') required String fullName,
      required String email,
      required String password,
      @JsonKey(name: '_id') @Default('') String id,
      @Default('') String state,
      @Default('') String city,
      @Default('') String locality,
      @Default('') String token}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
// class User extends Equatable {
//   const User({
//     required this.id,
//     required this.fullName,
//     required this.email,
//     required this.state,
//     required this.city,
//     required this.locality,
//     required this.password,
//   });

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['_id'] ?? '',
//       fullName: map['name'] ?? '',
//       email: map['email'] ?? '',
//       state: map['state'] ?? '',
//       city: map['city'] ?? '',
//       locality: map['locality'] ?? '',
//       password: map['password'] ?? '',
//     );
//   }

//   factory User.registration({
//     required fullName,
//     required email,
//     required password,
//   }) {
//     return User(
//         id: '',
//         fullName: fullName,
//         email: email,
//         state: '',
//         city: '',
//         locality: '',
//         password: password);
//   }

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
//   final String id;
//   final String fullName;
//   final String email;
//   final String state;
//   final String city;
//   final String locality;
//   final String password;

//   User copyWith({
//     String? id,
//     String? fullName,
//     String? email,
//     String? state,
//     String? city,
//     String? locality,
//     String? password,
//   }) {
//     return User(
//       id: id ?? this.id,
//       fullName: fullName ?? this.fullName,
//       email: email ?? this.email,
//       state: state ?? this.state,
//       city: city ?? this.city,
//       locality: locality ?? this.locality,
//       password: password ?? this.password,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       '_id': id,
//       'name': fullName,
//       'email': email,
//       'state': state,
//       'city': city,
//       'locality': locality,
//       'password': password,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   @override
//   String toString() {
//     return 'User(id: $id, fullName: $fullName, email: $email, state: $state, city: $city, locality: $locality, password: $password)';
//   }

//   @override
//   List<Object> get props {
//     return [
//       id,
//       fullName,
//       email,
//       state,
//       city,
//       locality,
//       password,
//     ];
//   }
// }
