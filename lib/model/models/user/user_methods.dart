import 'package:test_store_app/model/models/user/user.dart';

extension UserMethods on User {
  bool hasShippingData() {
    return state.isNotEmpty && city.isNotEmpty && locality.isNotEmpty;
  }
}
