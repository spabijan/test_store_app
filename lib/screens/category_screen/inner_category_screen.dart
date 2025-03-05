import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_store_app/screens/category_screen/components/inner_category_content.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/category_item_provider.dart';
import 'package:test_store_app/screens/navigation/provider/go_router_provider.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';
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
                navigateToProductDetails: _navigateToProductDetails)));
  }

  void _navigateToProductDetails(ProductViewModel product) {
    ref
        .read(routerProvider)
        .goNamed(RouteNames.categoryProduct, extra: product);
  }
}
