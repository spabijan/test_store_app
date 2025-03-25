import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';

part 'cart_total_amount.g.dart';

@riverpod
double cartTotalAmount(Ref ref) {
  final cart = ref.watch(cartProvider);
  return cart.maybeWhen(
      data: (data) => data.fold(
            0.0,
            (previousValue, element) =>
                previousValue + element.productPrice * element.orderQuantity,
          ),
      orElse: () => 0);
}

@riverpod
int cartTotalElements(Ref ref) {
  final cart = ref.watch(cartProvider);
  return cart.maybeWhen(
      orElse: () => 0,
      data: (data) => data.fold(0,
          (previousValue, element) => previousValue + element.orderQuantity));
}

@riverpod
List<CartModel> cartElement(Ref ref) {
  final cart = ref.watch(cartProvider);
  return cart.maybeWhen(orElse: List.empty, data: (data) => data);
}
