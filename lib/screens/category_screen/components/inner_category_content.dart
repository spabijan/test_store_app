import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/components/subcategory_tile_widget.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/popular_products_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/products_by_category_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategories_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';
import 'package:test_store_app/screens/components/banner/inner_banner_widget.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/widgets/section_header_widget.dart';

class InnerCategoryContent extends ConsumerStatefulWidget {
  const InnerCategoryContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InnerCategoryContentState();
}

class _InnerCategoryContentState extends ConsumerState<InnerCategoryContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final category = ref.read(categoryItemProvider);
      ref.read(subcategoriesProvider(category.name)).whenData((value) {
        if (value.isEmpty) {
          ref
              .read(subcategoriesProvider(category.name).notifier)
              .loadSubcategories();
        }
      });
      ref.read(productsByCategoryProvider(category.name)).whenData((value) {
        if (value.isEmpty) {
          ref
              .read(productsByCategoryProvider(category.name).notifier)
              .loadProducts();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                data: (data) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate((data.value.length / 7).ceil(),
                            (index) {
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
                                    .map((e) => ProviderScope(
                                            overrides: [
                                              subcategoryItemProvider
                                                  .overrideWithValue(e)
                                            ],
                                            child:
                                                const SubcategoryTileWidget()))
                                    .toList(),
                              ));
                        }),
                      ),
                    ),
                error: (_) => const SizedBox.shrink(),
                loading: (loading) =>
                    const CircularProgressIndicator.adaptive()),
            produts.map(
                data: (data) {
                  return Column(children: [
                    const SectionHeaderWidget(
                        title: 'Products', subtitle: 'View all'),
                    data.value.isEmpty
                        ? const Center(child: Text('No popular products'))
                        : SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.value.length,
                              itemBuilder: (context, index) {
                                return ProviderScope(overrides: [
                                  productItemProvider
                                      .overrideWithValue(data.value[index])
                                ], child: const ProductItemWidget());
                              },
                            ),
                          ),
                  ]);
                },
                error: (_) => const SizedBox.shrink(),
                loading: (loading) =>
                    const CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }
}
