import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/wishlist/models/wishlist_model.dart';

part 'wishlist_provider.g.dart';

@riverpod
int wishlistItemCount(Ref ref) {
  return ref.watch(wishlistProvider).length;
}

@Riverpod(keepAlive: true)
class Wishlist extends _$Wishlist {
  @override
  Map<String, WishlistModel> build() {
    return {};
  }

  void addProductToWishlist(WishlistModel cartProduct) {
    state = {...state, cartProduct.productId: cartProduct};
  }

  void removeWishlistItem(String id) {
    if (state.containsKey(id)) {
      Map<String, WishlistModel> newState = {};
      for (final entry in state.entries) {
        if (entry.key != id) {
          newState.addEntries({entry});
        }
      }
      state = newState;
    }
  }

  void clearCart() {
    state = {};
  }
}
