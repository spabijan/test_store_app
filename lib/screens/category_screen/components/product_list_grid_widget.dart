import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';

class ProductListGrid extends StatelessWidget {
  const ProductListGrid(
      {required this.productList, required this.onProductClicked, super.key});

  final List<ProductViewModel> productList;
  final Function(ProductViewModel product) onProductClicked;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth < 600 ? 2 : 4;
    final aspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;

    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => onProductClicked(productList[index]),
          child: ProviderScope(overrides: [
            productItemProvider.overrideWithValue(productList[index])
          ], child: const ProductItemWidget()),
        );
      },
    );
  }
}
