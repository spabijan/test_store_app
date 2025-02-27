import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/providers/category_provider.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/inner_category_screen.dart';
import 'package:test_store_app/screens/category_screen/components/category_item_widget.dart';
import 'package:test_store_app/screens/widgets/section_header_widget.dart';

class CategoryListWidget extends ConsumerStatefulWidget {
  const CategoryListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryListWidgetState();
}

class _CategoryListWidgetState extends ConsumerState<CategoryListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ref.read(categoriesProvider).whenData(
              (value) {
                if (value.isEmpty) {
                  ref.read(categoriesProvider.notifier).loadCategories();
                }
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        categoriesProvider,
        (previous, next) => next
                .whenOrNull<AsyncValue<List<CategoryViewModel>>>(
                    error: (error, stackTrace) {
              var errorMessage =
                  error is HttpError ? error.message : error.toString();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
              return null;
            }));

    final categories = ref.watch(categoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(title: 'Categories', subtitle: 'View all'),
        categories.map(
            data: (data) => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemCount: data.value.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProviderScope(overrides: [
                                      categoryItemProvider
                                          .overrideWithValue(data.value[index])
                                    ], child: const InnerCategoryScreen()))),
                        child: ProviderScope(overrides: [
                          categoryItemProvider
                              .overrideWithValue(data.value[index])
                        ], child: const CategoryListItemWidget())),
                  ),
                ),
            error: (errorState) {
              var e = errorState.error;
              var errorMessage =
                  e is HttpError ? e.message : errorState.error.toString();
              return Center(child: Text('Error $errorMessage'));
            },
            loading: (loading) => const CircularProgressIndicator.adaptive()),
      ],
    );
  }
}
