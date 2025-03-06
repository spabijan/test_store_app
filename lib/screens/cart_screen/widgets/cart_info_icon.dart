import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/r.dart';

class CartInfoIcon extends StatelessWidget {
  const CartInfoIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: 322,
            top: 52,
            child: Stack(
              children: [
                Image.asset(AssetIcons.not, width: 25, height: 25),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final items = ref.watch(cartTotalElementsProvider);
                    return items > 0
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.yellow.shade800),
                              child: Center(
                                  child: Text(items.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10))),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                )
              ],
            )),
        Positioned(
            left: 61,
            top: 51,
            child: Text(
              'My Cart',
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ],
    );
  }
}
