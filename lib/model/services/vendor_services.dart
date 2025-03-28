import 'dart:convert';

import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/vendor_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

final class VendorServices {
  VendorServices();

  Future<List<VendorModel>> getVendors() async {
    var response = await http.get(
        Uri.parse('${MyGlobalVariables.uri}/api/vendors'),
        headers: MyGlobalVariables.headers);
    HttpResponseUtils.checkForHttpResponseErrors(response: response);

    List<dynamic> data = jsonDecode(response.body);
    return [for (final datum in data) VendorModel.fromJson(datum)];
  }
}
