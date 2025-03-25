import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/place_order_button_state_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/create_payment_process_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/place_order_provider.dart';
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
      }, data: (data) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully placed order')));
        ref.watch(cartProvider.notifier).clearCart();
        Navigator.of(context).pop();
      });
    });

    ref.listen<AsyncValue<Map<String, dynamic>>>(createPaymentProcessProvider,
        (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      }, data: (paymentIntent) async {
        if (paymentIntent.isNotEmpty) {
          await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent['client_secret'],
                  merchantDisplayName: 'Wiecznie Marudny Kitku'));
          await Stripe.instance.presentPaymentSheet();
          final cartEntries = ref.read(cartElementProvider);
          ref.read(placeOrderProvider.notifier).placeOrder(cartEntries);
        }
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
                  return cart.maybeWhen(
                      data: (data) {
                        return ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return CartCheckoutListRow(item: item);
                            });
                      },
                      orElse: SizedBox.shrink);
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
            final buttonState = ref.watch(placeOrderButtonStateProvider);
            return switch (buttonState) {
              MissingAddressDataCheckoutButtonState() => BlueButton(
                  textButton: buttonState.message,
                  onTap: () => _navigateToAddress(context)),
              StripeSelectedCheckoutButtonState() => BlueButton(
                  textButton: buttonState.message,
                  onTap: () => _handleStripePayment(ref)),
              CashSelectedCheckoutButtonState() => BlueButton(
                  textButton: buttonState.message,
                  onTap: () => _handleCashpayment(ref)),
              LoadingCheckoutButtonState() => const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator.adaptive()))
            };
          },
        ),
      ),
    );
  }

  void _handleCashpayment(WidgetRef ref) {
    final cart = ref.read(cartElementProvider);
    ref.read(placeOrderProvider.notifier).placeOrder(cart);
  }

  void _handleStripePayment(WidgetRef ref) {
    final amount = ref.read(cartTotalAmountProvider);

    ref.read(createPaymentProcessProvider.notifier).createPaymentIntend(
        amount: (amount * 100).toInt(), // payment provider expects cents
        currency: 'usd');
  }

  void _navigateToAddress(BuildContext context) {
    GoRouter.of(context).goNamed(RouteNames.cartShippingAddress);
  }
}
