import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/popular_products_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/widgets/section_header_widget.dart';

class PopularProductsListWidget extends ConsumerWidget {
  const PopularProductsListWidget({required this.navigateToProduct, super.key});

  final Function(ProductViewModel productVM) navigateToProduct;

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHeaderWidget(
          title: 'Popular Products', subtitle: 'View all'),
      popualarProduct.map(
        data: (data) => data.value.isEmpty
            ? const Center(child: Text('No popular products'))
            : SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.value.length,
                  itemBuilder: (context, index) {
                    return ProviderScope(
                        overrides: [
                          productItemProvider
                              .overrideWithValue(data.value[index])
                        ],
                        child: InkWell(
                            onTap: () => navigateToProduct(data.value[index]),
                            child: const ProductItemWidget()));
                  },
                ),
              ),
        loading: (_) =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error) => const Center(child: Text('No popular products')),
      )
    ]);
  }
}
