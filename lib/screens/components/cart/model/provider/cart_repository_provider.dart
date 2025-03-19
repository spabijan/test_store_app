import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/components/cart/cart_repository.dart';

part 'cart_repository_provider.g.dart';

@riverpod
CartRepository cartRepository(Ref ref) {
  return CartRepository();
}
