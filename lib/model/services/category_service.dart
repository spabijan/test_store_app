import 'package:test_store_app/model/models/category/category.dart';
import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  Future<List<CategoryModel>> loadCategories() async {
    var response = await http.get(
        Uri.parse('${MyGlobalVariables.uri}/api/categories'),
        headers: MyGlobalVariables.headers);

    HttpResponseUtils.checkForHttpResponseErrors(response: response);

    List<dynamic> data = jsonDecode(response.body);
    return [for (final datum in data) CategoryModel.fromJson(datum)];
  }
}
