import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/services/manage_http_response.dart';

class AuthController {
  Future<void> signupUser(
      {required BuildContext context,
      required String email,
      required String fullName,
      required String password}) async {
    try {
      final user = User(fullName: fullName, email: email, password: password);

      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signup'),
          body: user.toJson(),
          headers: MyGlobalVariables.headers);

      HttpResponseUtils.manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          HttpResponseUtils.showSnackbar(context, 'Account has been created');
        },
      );
    } catch (e) {
      HttpResponseUtils.showSnackbar(context, e.toString());
    }
  }

  Future<void> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signIn'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: MyGlobalVariables.headers);

      HttpResponseUtils.manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          HttpResponseUtils.showSnackbar(context, 'User has been logged in');
        },
      );
    } catch (e) {
      HttpResponseUtils.showSnackbar(context, e.toString());
    }
  }
}
