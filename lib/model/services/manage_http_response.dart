import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';

class HttpError implements Exception {
  HttpError({required this.message});
  final String message;
}

final class HttpResponseUtils {
  HttpResponseUtils._();
  static void checkForHttpResponseErrors({
    required http.Response response,
  }) {
    switch (response.statusCode) {
      case 200 || 201 || 204:
        return; //status ok - nothing to return
      case 400 || 404 || 401:
        throw HttpError(message: json.decode(response.body)['msg']);
      case 500:
        throw HttpError(message: json.decode(response.body)['error']);
    }
  }
}
