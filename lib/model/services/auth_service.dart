import 'dart:convert';
import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';

sealed class AuthResult {}

final class SuccessAuthResult extends AuthResult {
  SuccessAuthResult({required this.userJson, required this.tokenJson});

  final String userJson;
  final String tokenJson;
}

final class FailedAuthResult extends AuthResult {}

class AuthService {
  Future<void> signupUser(
      {required String email,
      required String fullName,
      required String password}) async {
    return rethrowAnyError(() async {
      final user = User(fullName: fullName, email: email, password: password);
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signup'),
          body: json.encode(user.toJson()),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    });
  }

  Future<AuthResult> signInUser(
      {required String email, required String password}) async {
    return rethrowAnyError(() async {
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/signIn'),
          body: json.encode({'email': email, 'password': password}),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);

      String tokenJson = jsonDecode(response.body)['token'];
      final userJson = jsonEncode(jsonDecode(response.body)['user']);

      return SuccessAuthResult(userJson: userJson, tokenJson: tokenJson);
    });
  }

  Future<String> updateUserAddress(
      {required String id,
      required String city,
      required String state,
      required String locality}) async {
    return rethrowAnyError(() async {
      final http.Response response = await http.put(
          Uri.parse('${MyGlobalVariables.uri}/api/users/$id'),
          body:
              json.encode({'state': state, 'city': city, 'locality': locality}),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      final userJson = jsonEncode(jsonDecode(response.body)['user']);
      return userJson;
    });
  }

  Future<void> verifyOTP(String email, String otp) async {
    return rethrowAnyError(() async {
      final http.Response response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/verify-otp'),
          body: json.encode({'email': email, 'otp': otp}),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    });
  }

  Future<void> deleteAccount(
      {required String id, required String authToken}) async {
    return rethrowAnyError(() async {
      final http.Response response = await http.delete(
          Uri.parse('${MyGlobalVariables.uri}/api/users/$id'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': authToken});
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    });
  }

  Future<AuthResult> checkAuthToken({required String authToken}) async {
    return rethrowAnyError(() async {
      // first validate if stored token is valid
      final http.Response tokenValidationResponse = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/token-validation'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': authToken});
      HttpResponseUtils.checkForHttpResponseErrors(
          response: tokenValidationResponse);
      final tokenValid = jsonDecode(tokenValidationResponse.body);
      if (!tokenValid) {
        return FailedAuthResult();
      }

      // then retrieve user data from server
      final http.Response userDataResponse = await http.get(
          Uri.parse('${MyGlobalVariables.uri}/'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': authToken});
      HttpResponseUtils.checkForHttpResponseErrors(response: userDataResponse);
      String tokenJson = jsonDecode(userDataResponse.body)['token'];
      final userJson = jsonEncode(jsonDecode(userDataResponse.body)['user']);
      return SuccessAuthResult(userJson: userJson, tokenJson: tokenJson);
    });
  }

  Future<T> rethrowAnyError<T>(Future<T> Function() func) {
    try {
      return func();
    } catch (e) {
      rethrow;
    }
  }
}
