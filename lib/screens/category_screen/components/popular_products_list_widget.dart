import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/widgets/section_header_widget.dart';

class ProductsListWidget extends ConsumerWidget {
  const ProductsListWidget(
      {required this.sectionTitle,
      required this.products,
      required this.navigateToProduct,
      super.key});

  final String sectionTitle;
  final List<ProductViewModel> products;
  final Function(ProductViewModel productVM)? navigateToProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeaderWidget(title: sectionTitle, subtitle: 'View all'),
      products.isNotEmpty
          ? SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProviderScope(
                      overrides: [
                        productItemProvider.overrideWithValue(products[index])
                      ],
                      child: navigateToProduct != null
                          ? InkWell(
                              onTap: () => navigateToProduct!(products[index]),
                              child: const ProductItemWidget())
                          : const ProductItemWidget());
                },
              ),
            )
          : const Center(child: Text('No popular products'))
    ]);
  }
}
