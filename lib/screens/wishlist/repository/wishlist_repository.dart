import 'package:hive/hive.dart';
import 'package:test_store_app/screens/wishlist/models/wishlist_model.dart';

class WishlistRepository {
  final Box wishlistBox = Hive.box('wishlist');

  Future<List<WishlistModel>> getWishlistItems() async {
    try {
      if (wishlistBox.isEmpty) {
        return [];
      }
      return [
        for (final object in wishlistBox.values)
          WishlistModel.fromJson(Map<String, dynamic>.from(object))
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToWishlist({required WishlistModel model}) async {
    try {
      await wishlistBox.put(model.productId, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFromWishlist({required String id}) async {
    try {
      await wishlistBox.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
