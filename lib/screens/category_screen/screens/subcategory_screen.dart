import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/components/product_list_grid_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/subcategory_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/product_by_subcategory_provder.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/category_screen/screens/product_detail_screen.dart';

class SubcategoryScreen extends ConsumerStatefulWidget {
  const SubcategoryScreen({required this.subcategory, super.key});

  final SubcategoryViewModel subcategory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubcategoryScreenState();
}

class _SubcategoryScreenState extends ConsumerState<SubcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
        productBySubcategoryProvider(widget.subcategory.subcategoryName));

    return Scaffold(
        body: products.map(
            data: (data) {
              final productList = data.value;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductListGrid(
                    productList: productList,
                    onProductClicked: _gotoProductDetails),
              );
            },
            error: (error) => const Center(child: Text('An error occurred')),
            loading: (loading) =>
                const Center(child: CircularProgressIndicator.adaptive())),
        appBar: AppBar(title: Text(widget.subcategory.subcategoryName)));
  }

  void _gotoProductDetails(ProductViewModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(viewModel: product),
    ));
  }
}
