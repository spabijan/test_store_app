import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/order/order.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

class OrdersService {
  Future<void> uploadOrder({
    required OrderModel order,
    required String loginToken,
  }) async {
    try {
      var response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/orders'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': loginToken},
          body: jsonEncode(order.toJson()));
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrderById(
      {required String buyerID, required String loginToken}) async {
    try {
      var response = await http.get(
          Uri.parse('${MyGlobalVariables.uri}/api/orders/$buyerID'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': loginToken});

      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      List<dynamic> data = jsonDecode(response.body);
      return [for (final datum in data) OrderModel.fromJson(datum)];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrderById({required String orderId}) async {
    try {
      var response = await http
          .delete(Uri.parse('${MyGlobalVariables.uri}/api/orders/$orderId'));
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      {required int amount,
      required String currency,
      required String loginToken}) async {
    try {
      final response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/payment-intent'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': loginToken},
          body: jsonEncode({'amount': amount, 'currency': currency}));
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getIntentStatus(
      {required String intentId, required String loginToken}) async {
    try {
      final response = await http.get(
          Uri.parse('${MyGlobalVariables.uri}/api/payment-intent/$intentId'),
          headers: {...MyGlobalVariables.headers, 'x-auth-token': loginToken});
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
