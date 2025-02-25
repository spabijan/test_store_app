import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/models/baner/baner_model.dart';
import 'package:test_store_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<List<BannerModel>> loadBanners() async {
    var response = await http.get(
        Uri.parse('${MyGlobalVariables.uri}/api/banner'),
        headers: MyGlobalVariables.headers);

    HttpResponseUtils.checkForHttpResponseErrors(response: response);
    List<dynamic> data = jsonDecode(response.body);
    return [for (final datum in data) BannerModel.fromJson(datum)];
  }
}
