import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/components/subcategory_tile_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/subcategory_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/products_by_category_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategories_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';
import 'package:test_store_app/screens/components/banner/inner_banner_widget.dart';
import 'package:test_store_app/screens/widgets/section_header_widget.dart';

class InnerCategoryContent extends ConsumerWidget {
  const InnerCategoryContent(
      {required this.navigateToProductDetails,
      required this.navigateToSubcategory,
      super.key});

  final Function(ProductViewModel product) navigateToProductDetails;
  final Function(SubcategoryViewModel subcategory) navigateToSubcategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryItemProvider);
    final subcategories = ref.watch(subcategoriesProvider(category.name));
    final produts = ref.watch(productsByCategoryProvider(category.name));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InnerBannerScreen(imageUrl: category.banner),
            Center(
              child: Text('Shop By Subcategories',
                  style: GoogleFonts.quicksand(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.7)),
            ),
            subcategories.map(
                data: (data) => data.value.isEmpty
                    ? const Center(child: Text('No data found'))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: List.generate(
                              (data.value.length / 7).ceil(), (index) {
                            final start = index * 7;
                            final end = (index + 1) * 7;
                            return Padding(
                                padding: const EdgeInsets.all(8.9),
                                child: Row(
                                  children: data.value
                                      .sublist(
                                          start,
                                          end > data.value.length
                                              ? data.value.length
                                              : end)
                                      .map((e) => InkWell(
                                            onTap: () =>
                                                navigateToSubcategory(e),
                                            child: ProviderScope(
                                                overrides: [
                                                  subcategoryItemProvider
                                                      .overrideWithValue(e)
                                                ],
                                                child:
                                                    const SubcategoryTileWidget()),
                                          ))
                                      .toList(),
                                ));
                          }),
                        ),
                      ),
                error: (_) => const Center(child: Text('Ann error occurred')),
                loading: (loading) =>
                    const CircularProgressIndicator.adaptive()),
            produts.map(
                data: (data) {
                  return data.value.isEmpty
                      ? const Center(child: Text('No popular products'))
                      : Column(children: [
                          const SectionHeaderWidget(
                              title: 'Products', subtitle: 'View all'),
                          SizedBox(
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
                                        onTap: () => navigateToProductDetails(
                                            data.value[index]),
                                        child: const ProductItemWidget()));
                              },
                            ),
                          ),
                        ]);
                },
                error: (_) => const Center(child: Text('Ann error occurred')),
                loading: (loading) =>
                    const CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }
}
