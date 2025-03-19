import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';

class CartCheckupButton extends StatelessWidget {
  const CartCheckupButton({
    required this.gotoCheckout,
    this.isEnabled = true,
    super.key,
  });

  final bool isEnabled;
  final Function gotoCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                    width: 416,
                    height: 89,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffc4c4c4))))),
            Align(
                alignment: const Alignment(-0.63, -0.26),
                child: Text('Subtotal',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffa1a1a1)))),
            Align(
              alignment: const Alignment(-0.19, -0.26),
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final totalPrice = ref.watch(cartTotalAmountProvider);
                  return Text('\$$totalPrice',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: totalPrice > 0
                              ? const Color(0xffff6464)
                              : Colors.grey));
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.83, -1),
              child: InkWell(
                // ignore: unnecessary_lambdas
                onTap: () {
                  if (isEnabled) {
                    gotoCheckout();
                  }
                },
                child: Container(
                  width: 166,
                  height: 77,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: isEnabled
                          ? const Color(0xff1532e7)
                          : Colors.blueGrey.shade600,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Checkout ',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
