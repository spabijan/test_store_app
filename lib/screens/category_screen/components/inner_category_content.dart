import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/category_screen/components/subcategory_tile_widget.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategories_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';
import 'package:test_store_app/screens/components/banner/inner_banner_widget.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';

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
      ref.read(subcategoriesProvider(category.name)).whenData(
        (value) {
          if (value.isEmpty) {
            ref
                .read(subcategoriesProvider(category.name).notifier)
                .loadSubcategories();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryItemProvider);
    final subcategories = ref.watch(subcategoriesProvider(category.name));

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
                error: (errorState) {
                  var e = errorState.error;
                  var errorMessage =
                      e is HttpError ? e.message : errorState.error.toString();
                  return Center(child: Text('Error $errorMessage'));
                },
                loading: (loading) =>
                    const CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }
}
