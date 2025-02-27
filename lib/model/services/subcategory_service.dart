import 'package:test_store_app/model/models/subcategory/subcategory.dart';
import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final class SubcategoryService {
  Future<List<SubcategoryModel>> loadSubcategoriesByName(
      String categoryName) async {
    var response = await http.get(
        Uri.parse(
            '${MyGlobalVariables.uri}/api/category/$categoryName/subcategories'),
        headers: MyGlobalVariables.headers);

    HttpResponseUtils.checkForHttpResponseErrors(response: response);
    List<dynamic> data = jsonDecode(response.body);
    return [for (final datum in data) SubcategoryModel.fromJson(datum)];
  }
}
