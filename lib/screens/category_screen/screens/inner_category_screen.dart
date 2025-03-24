import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_store_app/screens/category_screen/components/inner_category_content.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/subcategory_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/category_screen/screens/product_detail_screen.dart';
import 'package:test_store_app/screens/category_screen/screens/subcategory_screen.dart';
import 'package:test_store_app/screens/widgets/header_widget.dart';

class InnerCategoryScreen extends ConsumerStatefulWidget {
  const InnerCategoryScreen({
    required this.categoryViewModel,
    super.key,
  });

  final CategoryViewModel categoryViewModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends ConsumerState<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
            child: Stack(
              children: [
                const HeaderWidget(),
                Positioned(
                  left: 4,
                  top: 68,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
              ],
            )),
        body: ProviderScope(
            overrides: [
              categoryItemProvider.overrideWithValue(widget.categoryViewModel)
            ],
            child: InnerCategoryContent(
                navigateToSubcategory: _navigateToSubcategoryDetails,
                navigateToProductDetails: _navigateToProductDetails)));
  }

  void _navigateToSubcategoryDetails(SubcategoryViewModel subcategory) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SubcategoryScreen(subcategory: subcategory),
    ));
  }

  void _navigateToProductDetails(ProductViewModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(viewModel: product),
    ));
  }
}
