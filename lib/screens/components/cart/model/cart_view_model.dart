import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';

class CartViewModel {
  CartViewModel({required CartModel cartModel}) : _cartModel = cartModel;

  final CartModel _cartModel;
}
