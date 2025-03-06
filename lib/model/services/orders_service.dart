import 'package:test_store_app/constants/my_global_variables.dart';
import 'package:test_store_app/model/models/order/order.dart';
import 'package:http/http.dart' as http;
import 'package:test_store_app/model/services/manage_http_response.dart';

class OrdersService {
  Future<void> uploadOrder({
    required String fullName,
    required String email,
    required String productName,
    required double productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required String city,
    required String state,
    required String locality,
  }) async {
    final order = OrderModel(
        fullName: fullName,
        email: email,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        city: city,
        state: state,
        locality: locality);

    var response = await http.post(
        Uri.parse('${MyGlobalVariables.uri}/api/orders'),
        headers: MyGlobalVariables.headers,
        body: order);
    HttpResponseUtils.checkForHttpResponseErrors(response: response);
  }
}
