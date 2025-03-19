import 'package:hive/hive.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';

class CartRepository {
  final Box cartBox = Hive.box('cart');

  Future<List<CartModel>> getCartItems() async {
    try {
      if (cartBox.isEmpty) {
        return [];
      }
      return [
        for (final object in cartBox.values)
          CartModel.fromJson(Map<String, dynamic>.from(object))
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToCart({required CartModel model}) async {
    try {
      await cartBox.put(model.productId, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromCart({required String id}) async {
    try {
      await cartBox.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearCart() async {
    try {
      await cartBox.deleteAll(cartBox.keys);
    } catch (e) {
      rethrow;
    }
  }
}
