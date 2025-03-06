import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';

class CartCheckoutListRow extends StatelessWidget {
  const CartCheckoutListRow({
    required this.item,
    super.key,
  });

  final CartModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 336,
        height: 91,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xffeff0f2))),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
                left: 6,
                top: 6,
                child: SizedBox(
                    width: 311,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 78,
                          height: 78,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xffbcc5ff)),
                          child: Image.network(item.image.first),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Container(
                          height: 78,
                          alignment: const Alignment(0, -0.51),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(item.productName,
                                      style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.3)),
                                ),
                                const SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(item.category,
                                      style: GoogleFonts.lato(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w400,
                                      )),
                                )
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(width: 16),
                        Text('${item.productPrice.toStringAsFixed(2)}\$',
                            style: GoogleFonts.lato(
                              color: Colors.pink,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
