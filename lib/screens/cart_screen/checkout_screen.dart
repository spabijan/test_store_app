import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/models/cart/cart_model.dart';
import 'package:test_store_app/model/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/model/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/screens/cart_screen/providers/selected_payment_method_provider.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_chekout_list_row.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_payment_method_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/delivery_address_tile.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const DeliveryAddressTileWidget(),
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
        child: Container(
          width: 338,
          height: 58,
          decoration: BoxDecoration(
              color: const Color(0xff3854ee),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final buttonText = ref.watch(selectedPaymentMethodProvider);
                return Text(buttonText.checkoutMessage,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18));
              },
            ),
          ),
        ),
      ),
    );
  }
}
