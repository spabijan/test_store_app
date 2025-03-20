import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';

final class MyGlobalVariables {
  MyGlobalVariables._();
  static const String uri = 'http://192.168.1.134:3000';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json;  charset=UTF-8'
  };
}
