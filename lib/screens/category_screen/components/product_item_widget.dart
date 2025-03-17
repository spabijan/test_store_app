import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';

class ProductItemWidget extends ConsumerWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productItemProvider);
    return Container(
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(24)),
            child: Stack(
              children: [
                Image.network(
                  product.images.first,
                  height: 170,
                  width: 170,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 12,
                    right: 8,
                    child: Image.asset(AssetIcons.love, width: 24, height: 26)),
                Positioned(
                    bottom: 12,
                    right: 8,
                    child: Image.asset(AssetIcons.cart, width: 24, height: 26))
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xff212121))),
          const SizedBox(height: 4),
          Text(product.category,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: const Color(0xff212121))),
          const SizedBox(height: 4),
          Text('\$${product.productPrice.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: const Color(0xff212121))),
        ],
      ),
    );
  }
}
