import 'dart:convert';

import 'package:http/http.dart' as http;

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
      case 400 || 404:
        throw HttpError(message: json.decode(response.body)['msg']);
      case 500:
        throw HttpError(message: json.decode(response.body)['error']);
    }
  }
}

//   void showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
// }
