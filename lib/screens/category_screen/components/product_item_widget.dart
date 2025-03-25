import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/wishlist/models/wishlist_model.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';

class ProductItemWidget extends ConsumerWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(wishlistProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    });
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
                    top: 4,
                    right: 8,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final wishlist = ref.watch(wishlistProvider);
                        return wishlist.maybeWhen(
                          data: (data) {
                            return IconButton(
                                onPressed: () {
                                  if (!data.any((element) =>
                                      element.productId == product.productId)) {
                                    _addToFavrites(ref, product, context);
                                  } else {
                                    _removeFromFavorites(ref, product, context);
                                  }
                                },
                                icon: Icon(
                                    data.any((element) =>
                                            element.productId ==
                                            product.productId)
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    size: 24));
                          },
                          orElse: SizedBox.shrink,
                        );
                      },
                    )),
                Positioned(
                    bottom: 4,
                    right: 8,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final cartRepository = ref.watch(cartProvider);
                        return cartRepository.maybeMap(
                            data: (data) => IconButton(
                                onPressed: () {
                                  _addToCart(ref, product, context);
                                },
                                icon: const Icon(Icons.shopping_cart_outlined)),
                            orElse: SizedBox.shrink);
                      },
                    ))
              ],
            ),
          ),
          Text(product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xff212121))),
          product.hasReviews
              ? Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      product.averageRating.toStringAsFixed(1),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          Text(product.category,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: const Color(0xff212121))),
          const SizedBox(height: 2),
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

  void _addToCart(
      WidgetRef ref, ProductViewModel product, BuildContext context) {
    ref
        .read(cartProvider.notifier)
        .addProductToCart(CartModel.fromProduct(product));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${product.productName} to cart')));
  }

  void _addToFavrites(
      WidgetRef ref, ProductViewModel product, BuildContext context) {
    ref
        .read(wishlistProvider.notifier)
        .addProductToWishlist(WishlistModel.fromProduct(product));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${product.productName} to wishlist')));
  }

  void _removeFromFavorites(
      WidgetRef ref, ProductViewModel product, BuildContext context) {
    ref.read(wishlistProvider.notifier).removeWishlistItem(product.productId);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Removed ${product.productName} from wishlist')));
  }
}
