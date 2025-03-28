import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/model/models/vendor_model.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/category_screen/components/product_list_grid_widget.dart';
import 'package:test_store_app/screens/category_screen/components/vendor_item_widget.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/screens/stores/providers/verndor_list_provider.dart';
import 'package:test_store_app/screens/stores/vendor_products_screen.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final items = ref.watch(cartTotalElementsProvider);
              return AppBarWidget(
                text: 'Stores',
                itemCount: items,
              );
            },
          ),
        ),
        bottomNavigationBar: NavigationTapBar(),
        body: Consumer(builder: (_, WidgetRef ref, __) {
          final vendorList = ref.watch(vendorListProvider);

          return vendorList.map(
            data: (data) {
              return ManagedListGrid<VendorModel>(
                  gridElements: data.value,
                  onTileClicked: (product) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VendorProductsScreen(vendor: product)));
                  },
                  child: const VendorItemWidget());
            },
            error: (error) => Center(
                child: Column(children: [
              Text('An error occurred. $error'),
              TextButton(
                  onPressed: () => ref.invalidate(vendorListProvider),
                  child: const Text('Refresh'))
            ])),
            loading: (_) =>
                const Center(child: CircularProgressIndicator.adaptive()),
          );
        }));
  }
}
