import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';

class CartItemsHeader extends StatelessWidget {
  const CartItemsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 49,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 49,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(color: Color(0xffd7ddff)),
                )),
            Positioned(
                left: 44,
                top: 19,
                child: Container(
                    width: 10,
                    height: 10,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)))),
            Positioned(
                left: 69,
                top: 14,
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final items = ref.watch(cartTotalElementsProvider);
                    return Text(
                      'You Have $items items',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7),
                    );
                  },
                ))
          ],
        ));
  }
}
