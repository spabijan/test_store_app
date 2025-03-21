import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/product/product.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

class ProductServices {
  Future<List<ProductModel>> loadPopularProducts() async {
    return await _loadProductsByRequest(
        '${MyGlobalVariables.uri}/api/popular-products');
  }

  Future<List<ProductModel>> loadProductsByCategory(String category) async {
    return await _loadProductsByRequest(
        '${MyGlobalVariables.uri}/api/products-by-category/$category');
  }

  Future<List<ProductModel>> loadTopRatedProducts() async {
    return await _loadProductsByRequest(
        '${MyGlobalVariables.uri}/api/top-rated-products');
  }

  Future<List<ProductModel>> loadRelatedProducts(String productId) async {
    return await _loadProductsByRequest(
        '${MyGlobalVariables.uri}/api/related-products/$productId');
  }

  Future<List<ProductModel>> _loadProductsByRequest(String request) async {
    try {
      var response = await http.get(Uri.parse(request),
          headers: MyGlobalVariables.headers);
      HttpResponseUtils.checkForHttpResponseErrors(response: response);

      List<dynamic> data = jsonDecode(response.body);
      return [for (final datum in data) ProductModel.fromJson(datum)];
    } catch (e) {
      rethrow;
    }
  }
}
