import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/category_screen/components/popular_products_list_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/popular_products_provider.dart';

class PopularProductsComponent extends ConsumerWidget {
  const PopularProductsComponent({this.navigateToProduct, super.key});

  final Function(ProductViewModel productVM)? navigateToProduct;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
        popularProductsProvider,
        (previous, next) => next.whenOrNull<AsyncValue<List<PopularProducts>>>(
                error: (error, stackTrace) {
              var errorMessage =
                  error is HttpError ? error.message : error.toString();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
              return null;
            }));

    final popualarProduct = ref.watch(popularProductsProvider);
    return popualarProduct.map(
        loading: (_) =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error) => const Center(child: Text('No popular products')),
        data: (data) {
          return ProductsListWidget(
            sectionTitle: 'Popular products',
            products: data.value,
            navigateToProduct: navigateToProduct,
          );
        });
  }
}
