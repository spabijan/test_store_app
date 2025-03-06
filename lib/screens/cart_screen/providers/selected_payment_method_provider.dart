import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/cart_screen/constants/payment_types.dart';

final selectedPaymentMethodProvider = StateProvider<PaymentTypes>((ref) {
  return PaymentTypes.stripe;
});
