import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/user/user_methods.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/constants/payment_types.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/create_payment_process_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/place_order_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/selected_payment_method_provider.dart';

part 'place_order_button_state_provider.g.dart';

sealed class CheckoutButtonState {}

final class MissingAddressDataCheckoutButtonState extends CheckoutButtonState {
  final message = 'Missing address data';
}

final class StripeSelectedCheckoutButtonState extends CheckoutButtonState {
  final message = PaymentTypes.stripe.checkoutMessage;
}

final class CashSelectedCheckoutButtonState extends CheckoutButtonState {
  final message = PaymentTypes.cash.checkoutMessage;
}

final class LoadingCheckoutButtonState extends CheckoutButtonState {}

@riverpod
class PlaceOrderButtonState extends _$PlaceOrderButtonState {
  @override
  CheckoutButtonState build() {
    final placeOrder = ref.watch(placeOrderProvider);
    final createPayment = ref.watch(createPaymentProcessProvider);
    if (placeOrder.isLoading || createPayment.isLoading) {
      return LoadingCheckoutButtonState();
    }

    final userHasShippingData = ref.watch(
        loggedUserProvider.select((it) => it?.hasShippingData() ?? false));
    if (!userHasShippingData) {
      return MissingAddressDataCheckoutButtonState();
    }

    final selectedPayment = ref.watch(selectedPaymentMethodProvider);

    return switch (selectedPayment) {
      PaymentTypes.stripe => StripeSelectedCheckoutButtonState(),
      PaymentTypes.cash => CashSelectedCheckoutButtonState(),
    };
  }
}
