import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/models/vendor_model.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/category_screen/components/product_item_widget.dart';
import 'package:test_store_app/screens/category_screen/components/product_list_grid_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/products_by_vendro_provider.dart';
import 'package:test_store_app/screens/category_screen/screens/product_detail_screen.dart';

class VendorProductsScreen extends StatelessWidget {
  const VendorProductsScreen({required this.vendor, super.key});

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final products =
                  ref.watch(vendorProductCounterProvider(vendor.id));
              return AppBarWidget(
                onBack: () => Navigator.of(context).pop(),
                text: vendor.fullName,
                itemCount: products,
              );
            },
          ),
        ),
        body: Consumer(builder: (context, ref, child) {
          final productsList = ref.watch(productsByVendorsProvider(vendor.id));
          return productsList.map(
              data: (data) => ManagedListGrid<ProductViewModel>(
                  gridElements: data.value,
                  onTileClicked: (model) => _gotoProductDetails(context, model),
                  child: const ProductItemWidget()),
              error: (error) => Center(
                    child: Column(
                      children: [
                        Text('An error occurred $error'),
                        TextButton(
                            onPressed: () => ref.invalidate(
                                productsByVendorsProvider(vendor.id)),
                            child: const Text('Refresh'))
                      ],
                    ),
                  ),
              loading: (_) =>
                  const Center(child: CircularProgressIndicator.adaptive()));
        }));
  }

  void _gotoProductDetails(BuildContext context, ProductViewModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(viewModel: product),
    ));
  }
}
