import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/category_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategories_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/components/category_item_widget.dart';
import 'package:test_store_app/screens/widgets/header_widget.dart';
import 'package:test_store_app/screens/category_screen/components/subcategory_list_item.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  CategoryViewModel? _selectedCategory;

  void _setCategory(CategoryViewModel category) {
    setState(() => _selectedCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    _showErrorSnackbar(context);
    _setDefaultCategory();

    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
          child: const HeaderWidget()),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey.shade200,
                child: categories.map(
                    data: (data) {
                      return ListView.builder(
                          itemCount: data.value.length,
                          itemBuilder: (context, index) {
                            var category = data.value[index];
                            return ListTile(
                              onTap: () => _setCategory(category),
                              title: Text(
                                category.name,
                                style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedCategory == category
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            );
                          });
                    },
                    error: (errorState) {
                      var e = errorState.error;
                      var errorMessage = e is HttpError
                          ? e.message
                          : errorState.error.toString();
                      return Center(child: Text('Error $errorMessage'));
                    },
                    loading: (loading) =>
                        const CircularProgressIndicator.adaptive()),
              )),
          Expanded(
              flex: 5,
              child: _selectedCategory != null
                  ? Column(children: [
                      ProviderScope(overrides: [
                        categoryItemProvider
                            .overrideWithValue(_selectedCategory!)
                      ], child: const CategoryItemWidget()),
                      if (_selectedCategory != null)
                        Consumer(builder: (context, ref, child) {
                          var subcategoriesState = ref.watch(
                              subcategoriesProvider(_selectedCategory!.name));
                          return subcategoriesState.map(
                              data: (data) => GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.value.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 8),
                                    itemBuilder: (context, index) =>
                                        ProviderScope(overrides: [
                                      subcategoryItemProvider
                                          .overrideWithValue(data.value[index])
                                    ], child: const SubcategoryListItem()),
                                  ),
                              error: (errorState) {
                                var e = errorState.error;
                                var errorMessage = e is HttpError
                                    ? e.message
                                    : errorState.error.toString();
                                return Center(
                                    child: Text('Error $errorMessage'));
                              },
                              loading: (loading) =>
                                  const CircularProgressIndicator.adaptive());
                        })
                    ])
                  : const SizedBox.shrink())
        ],
      ),
      bottomNavigationBar: NavigationTapBar(),
    );
  }

  void _setDefaultCategory() {
    ref.read(categoriesProvider).whenData((value) {
      if (_selectedCategory == null && value.isNotEmpty) {
        for (final category in value) {
          if (category.name == 'Fashion') {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _setCategory(category));
          }
        }
      }
    });
  }

  void _showErrorSnackbar(BuildContext context) {
    ref.listen(categoriesProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        var errorMessage =
            error is HttpError ? error.message : error.toString();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      });
    });
  }
}
