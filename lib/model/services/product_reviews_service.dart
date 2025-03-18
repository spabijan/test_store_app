import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/product_review/product_review_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

class ProductReviewsService {
  Future<void> addReview(
      {required String buyerId,
      required String email,
      required String fullName,
      required String productId,
      required double rating,
      required String review}) async {
    try {
      final newReview = ProductReviewModel(
          buyerId: buyerId,
          email: email,
          fullName: fullName,
          productId: productId,
          rating: rating,
          review: review);

      var response = await http.post(
          Uri.parse('${MyGlobalVariables.uri}/api/product-review'),
          headers: MyGlobalVariables.headers,
          body: jsonEncode(newReview.toJson()));
      HttpResponseUtils.checkForHttpResponseErrors(response: response);
    } catch (e) {
      rethrow;
    }
  }
}
