import 'package:decimal/decimal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/cart/provider/cart_provider.dart';

part 'total_amount_provider.g.dart';

@riverpod
Decimal totalAmount(Ref ref) {
  final cart = ref.watch(cartProvider);

  Decimal amount = Decimal.fromInt(0);

  for (final cartValue in cart.values) {
    amount += cartValue.productPrice * Decimal.fromInt(cartValue.orderQuantity);
  }
  return amount;
}
