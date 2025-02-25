import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/services/manage_http_response.dart';

class AuthService {
  Future<void> signupUser(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      final user = User(fullName: fullName, email: email, password: password);
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signup'),
          body: json.encode(user.toJson()),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    try {
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signIn'),
          body: json.encode({'email': email, 'password': password}),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    } catch (e) {
      rethrow;
    }
  }
}
