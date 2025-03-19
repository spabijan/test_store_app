import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_list_item_provider.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';

class WishlistListTileItem extends ConsumerWidget {
  const WishlistListTileItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistData = ref.watch(wishlistListItemProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Container(
          width: 355,
          height: 97,
          clipBehavior: Clip.none,
          child: SizedBox(
              width: double.infinity,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                        width: 336,
                        height: 97,
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200)))),
                Positioned(
                    left: 13,
                    top: 9,
                    child: Container(
                        width: 78,
                        height: 78,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xffbcc5ff)))),
                Positioned(
                    left: 275,
                    top: 16,
                    child: Text(
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0b0c1f)),
                        '\$${wishlistData.productPrice.toStringAsFixed(2)}')),
                Positioned(
                    left: 101,
                    top: 14,
                    child: SizedBox(
                      width: 162,
                      child: Text(wishlistData.productName,
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )),
                Positioned(
                    left: 23,
                    top: 14,
                    child: Image.network(wishlistData.image.first,
                        width: 58, height: 67, fit: BoxFit.cover)),
                Positioned(
                    left: 284,
                    top: 47,
                    child: IconButton(
                        onPressed: () => {
                              ref
                                  .read(wishlistProvider.notifier)
                                  .removeWishlistItem(wishlistData.productId)
                            },
                        icon: Image.asset(AssetIcons.delete,
                            width: 25, height: 25)))
              ])),
        )));
  }
}
