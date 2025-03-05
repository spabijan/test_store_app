import 'package:decimal/decimal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/cart/provider/cart_provider.dart';

part 'cart_total_amount.g.dart';

@riverpod
Decimal cartTotalAmount(Ref ref) {
  final cart = ref.watch(cartProvider);

  Decimal amount = Decimal.fromInt(0);

  for (final cartValue in cart.values) {
    amount += cartValue.productPrice * Decimal.fromInt(cartValue.orderQuantity);
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
