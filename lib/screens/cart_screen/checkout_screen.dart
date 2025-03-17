import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/models/user/user_methods.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/cart_screen/constants/payment_types.dart';
import 'package:test_store_app/screens/cart_screen/providers/place_order_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/selected_payment_method_provider.dart';
import 'package:test_store_app/screens/cart_screen/widgets/blue_button.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_chekout_list_row.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_payment_method_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/delivery_address_tile.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(placeOrderProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
      next.whenData((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully placed order')));
        ref.watch(cartProvider.notifier).clearCart();
        Navigator.of(context).pop();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeliveryAddressTileWidget(
                  navigateToAddressScreen: () => _navigateToAddress(context)),
              const SizedBox(height: 10),
              Text('Your Item',
                  style: GoogleFonts.quicksand(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Flexible(child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final cart = ref.watch(cartProvider);
                  return ListView.builder(
                      itemCount: cart.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = cart.values.toList()[index];
                        return CartCheckoutListRow(item: item);
                      });
                },
              )),
              const SizedBox(height: 10),
              Text('Choose payment method',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const PaymentSelectionWidget()
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 42, top: 8, left: 8, right: 8),
        child: Consumer(
          builder: (_, WidgetRef ref, __) {
            final paymentType = ref.watch(selectedPaymentMethodProvider);
            final cart = ref.watch(cartProvider);
            return BlueButton(
                onTap: () {
                  if (_userHasShippingData(ref)) {
                    switch (paymentType) {
                      case PaymentTypes.stripe:
                        throw UnimplementedError();
                      case PaymentTypes.cash:
                        ref
                            .read(placeOrderProvider.notifier)
                            .placeOrder(cart.values.toList());
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Missing address data')));
                  }
                },
                textButton: _getTextButton(paymentType, ref));
          },
        ),
      ),
    );
  }

  void _navigateToAddress(BuildContext context) {
    GoRouter.of(context).goNamed(RouteNames.cartShippingAddress);
  }

  bool _userHasShippingData(WidgetRef ref) {
    final user = ref.watch(loggedUserProvider);
    return user != null && user.hasShippingData();
  }

  String _getTextButton(PaymentTypes paymentType, WidgetRef ref) {
    if (!_userHasShippingData(ref)) {
      return 'Please enter Shipping Address';
    } else {
      return paymentType.checkoutMessage;
    }
  }
}
