import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final class HttpResponseUtils {
  HttpResponseUtils._();
  static void manageHttpResponse(
      {required http.Response response,
      required BuildContext context,
      required VoidCallback onSuccess}) {
    switch (response.statusCode) {
      case 200 || 201:
        onSuccess();
      case 400:
        showSnackbar(context, json.decode(response.body)['msg']);
      case 500:
        showSnackbar(context, json.decode(response.body)['error']);
    }
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
