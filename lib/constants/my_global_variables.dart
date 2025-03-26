import 'package:flutter_dotenv/flutter_dotenv.dart';

final class MyGlobalVariables {
  MyGlobalVariables._();
  static String uri = dotenv.get('BACKEND_API_SERVER_TEST');
  //static String uri = dotenv.get('BACKEND_API_SERVER');
  static const Map<String, String> headers = {
    'Content-Type': 'application/json;  charset=UTF-8'
  };
}
