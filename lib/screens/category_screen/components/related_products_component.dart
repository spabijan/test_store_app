import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/category_screen/components/popular_products_list_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/related_products_provider.dart';

class RelatedProductsComponent extends ConsumerWidget {
  const RelatedProductsComponent(
      {required this.relatedProduct, this.navigateToProduct, super.key});

  final ProductViewModel relatedProduct;
  final Function(ProductViewModel productVM)? navigateToProduct;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        relatedProductsProvider(relatedProduct.productId),
        (previous, next) => next.whenOrNull<AsyncValue<List<RelatedProducts>>>(
                error: (error, stackTrace) {
              var errorMessage =
                  error is HttpError ? error.message : error.toString();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
              return null;
            }));

    final popualarProduct =
        ref.watch(relatedProductsProvider(relatedProduct.productId));
    return popualarProduct.map(
        loading: (_) =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error) => const Center(child: Text('No related products')),
        data: (data) {
          return ProductsListWidget(
            sectionTitle: 'Related Products',
            products: data.value,
            navigateToProduct: navigateToProduct,
          );
        });
  }
}
