import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/components/popular_products_component.dart';
import 'package:test_store_app/screens/category_screen/inner_category_screen.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/product_detail_screen.dart';
import 'package:test_store_app/screens/category_screen/providers/popular_products_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/top_rated_products_provider.dart';
import 'package:test_store_app/screens/components/banner/banners_list_widget.dart';
import 'package:test_store_app/screens/category_screen/components/category_list_widget.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/screens/widgets/header_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height) * 0.2,
          child: const HeaderWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerListWidget(),
            CategoryListWidget(
                navigateToCategory: (categoryVM) =>
                    _gotoCategoryDetails(context, categoryVM)),
            ProductTileListWidget(
                message: 'Popular products',
                popularProductsProvider: popularProductsProvider,
                navigateToProduct: (productVM) =>
                    _gotoProductDetails(context, productVM)),
            const SizedBox(height: 32),
            ProductTileListWidget(
                message: 'Top rated products',
                popularProductsProvider: topRatedProductsProvider,
                navigateToProduct: (productVM) =>
                    _gotoProductDetails(context, productVM))
          ],
        ),
      ),
      bottomNavigationBar: NavigationTapBar(),
    );
  }

  void _gotoCategoryDetails(BuildContext context, CategoryViewModel category) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InnerCategoryScreen(categoryViewModel: category),
    ));
  }

  void _gotoProductDetails(BuildContext context, ProductViewModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(viewModel: product),
    ));
  }
}
