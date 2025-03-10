import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

final class AuthResult {
  AuthResult({required this.userJson, required this.tokenJson});

  final String userJson;
  final String tokenJson;
}

class AuthService {
  Future<void> signupUser(
      {required String email,
      required String fullName,
      required String password}) async {
    final user = User(fullName: fullName, email: email, password: password);
    final http.Response response = await http.post(
        Uri.parse('${MyGlobalVariables.uri}/api/signup'),
        body: json.encode(user.toJson()),
        headers: MyGlobalVariables.headers);
    HttpResponseUtils.checkForHttpResponseErrors(response: response);
  }

  Future<AuthResult> signInUser(
      {required String email, required String password}) async {
    final http.Response response = await http.post(
        Uri.parse('${MyGlobalVariables.uri}/api/signIn'),
        body: json.encode({'email': email, 'password': password}),
        headers: MyGlobalVariables.headers);
    HttpResponseUtils.checkForHttpResponseErrors(response: response);

    String tokenJson = jsonDecode(response.body)['token'];
    final userJson = jsonEncode(jsonDecode(response.body)['user']);

    return AuthResult(userJson: userJson, tokenJson: tokenJson);
  }

  Future<String> updateUserAddress(
      {required String id,
      required String city,
      required String state,
      required String locality}) async {
    final http.Response response = await http.put(
        Uri.parse('${MyGlobalVariables.uri}/api/users/$id'),
        body: json.encode({'state': state, 'city': city, 'locality': locality}),
        headers: MyGlobalVariables.headers);
    HttpResponseUtils.checkForHttpResponseErrors(response: response);
    final userJson = jsonEncode(jsonDecode(response.body)['user']);
    return userJson;
  }
}
