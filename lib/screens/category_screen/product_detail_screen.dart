import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/category_screen/components/related_products_component.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/wishlist/models/wishlist_model.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.viewModel, super.key});
  final ProductViewModel viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                var wishlist = ref.watch(wishlistProvider);
                return wishlist.maybeWhen(
                    data: (data) {
                      return IconButton(onPressed: () {
                        if (data.any((element) =>
                            element.productId == viewModel.productId)) {
                          _removeFromWishlist(context, ref);
                        } else {
                          _addToWishlist(context, ref);
                        }
                      }, icon: Consumer(
                        builder: (_, WidgetRef ref, __) {
                          return (data.any((element) =>
                                  element.productId == viewModel.productId))
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border);
                        },
                      ));
                    },
                    orElse: SizedBox.shrink);
              },
            )
          ],
          title: Text('Product Detail',
              style: GoogleFonts.quicksand(
                  fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Container(
                    width: 260,
                    height: 275,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(clipBehavior: Clip.none, children: [
                      Positioned(
                          left: 0,
                          top: 50,
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(130),
                                  color: const Color(0xffd8ddff)),
                              width: 260,
                              height: 260)),
                      Positioned(
                          left: 22,
                          top: 0,
                          child: Container(
                            width: 216,
                            height: 274,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: const Color(0xff9ca8ff),
                                borderRadius: BorderRadius.circular(14)),
                            child: SizedBox(
                              height: 300,
                              child: PageView.builder(
                                  itemCount: viewModel.images.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                        viewModel.images[index],
                                        width: 198,
                                        height: 255,
                                        fit: BoxFit.cover);
                                  }),
                            ),
                          ))
                    ]))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(viewModel.productName,
                      style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: const Color(0xff3c55ef))),
                  Text('\$ ${viewModel.productPrice}',
                      style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: const Color(0xff3c55ef)))
                ],
              ),
            ),
            viewModel.hasReviews
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '${viewModel.averageRating.toStringAsFixed(1)} (${viewModel.totalRatings})',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.category,
                        style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'About:',
                        style: GoogleFonts.lato(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.7,
                            color: const Color.fromARGB(255, 45, 18, 9)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel.description,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            color: Colors.grey),
                      )
                    ])),
            const SizedBox(height: 32),
            RelatedProductsComponent(
                relatedProduct: viewModel,
                navigateToProduct: (productVM) => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(viewModel: productVM))))
          ]),
        ),
        bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: InkWell(
              onTap: () {
                _addToCart(context, ref);
              },
              child: Container(
                width: 386,
                height: 46,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: const Color(0xFF3b54ee),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text('Add to cart',
                      style: GoogleFonts.mochiyPopOne(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            )));
  }

  void _addToWishlist(BuildContext context, WidgetRef ref) {
    ref
        .read(wishlistProvider.notifier)
        .addProductToWishlist(WishlistModel.fromProduct(viewModel));

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${viewModel.productName} to wishlist')));
  }

  void _addToCart(BuildContext context, WidgetRef ref) {
    ref
        .read(cartProvider.notifier)
        .addProductToCart(CartModel.fromProduct(viewModel));

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${viewModel.productName} to cart')));
  }

  void _removeFromWishlist(BuildContext context, WidgetRef ref) {
    ref.read(wishlistProvider.notifier).removeWishlistItem(viewModel.productId);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Removed ${viewModel.productName} from wishlist')));
  }
}
