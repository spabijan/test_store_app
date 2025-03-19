import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/wishlist/repository/wishlist_repository.dart';

part 'wishlist_repository_provider.g.dart';

@riverpod
WishlistRepository wishlistRepository(Ref ref) {
  return WishlistRepository();
}
