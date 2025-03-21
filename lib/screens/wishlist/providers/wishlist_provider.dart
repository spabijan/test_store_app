import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/wishlist/models/wishlist_model.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_repository_provider.dart';

part 'wishlist_provider.g.dart';

@Riverpod(keepAlive: true)
int wishlistItemCount(Ref ref) {
  return ref
      .watch(wishlistProvider)
      .maybeWhen(data: (data) => data.length, orElse: () => 0);
}

@Riverpod(keepAlive: true)
class Wishlist extends _$Wishlist {
  @override
  FutureOr<List<WishlistModel>> build() async {
    return await _getWishlist();
  }

  FutureOr<List<WishlistModel>> _getWishlist() async {
    return await ref.read(wishlistRepositoryProvider).getWishlistItems();
  }

  void addProductToWishlist(WishlistModel wishlistProduct) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        await ref
            .read(wishlistRepositoryProvider)
            .addToWishlist(model: wishlistProduct);
        return [
          ...state.value!,
          wishlistProduct,
        ];
      },
    );
  }

  void removeWishlistItem(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(wishlistRepositoryProvider).removeFromWishlist(id: id);
      return [
        for (final wishlistProduct in state.value!)
          if (wishlistProduct.productId != id) wishlistProduct
      ];
    });
  }

  Future<void> clearWishList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(wishlistRepositoryProvider).clearWishlist();
      return [];
    });
  }
}

@riverpod
int wishlistCount(Ref ref) {
  return ref
      .read(wishlistProvider)
      .maybeMap(data: (data) => data.value.length, orElse: () => 0);
}
