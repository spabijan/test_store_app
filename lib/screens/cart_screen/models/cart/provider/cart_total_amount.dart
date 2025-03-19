import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';

part 'cart_total_amount.g.dart';

@riverpod
double cartTotalAmount(Ref ref) {
  final cart = ref.watch(cartProvider);

  double amount = 0.0;

  for (final cartValue in cart.values) {
    amount += cartValue.productPrice * cartValue.orderQuantity;
  }
  return amount;
}

@riverpod
int cartTotalElements(Ref ref) {
  final cart = ref.watch(cartProvider);
  int total = 0;

  for (final cartValue in cart.values) {
    total += cartValue.orderQuantity;
  }

  return total;
}
