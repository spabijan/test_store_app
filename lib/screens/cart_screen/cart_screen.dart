import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/screens/cart_screen/providers/cart_list_item_provider.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_goto_checkup_button.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_items_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_list_item.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/screens/navigation/provider/go_router_provider.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
              text: 'My Cart',
              itemCount: items,
            );
          },
        ),
      ),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final cartData = ref.watch(cartProvider);
          return cartData.maybeWhen(
              data: (data) {
                return data.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Your shopping cart is empty',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade900))
                        ],
                      ))
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CartItemsHeader(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final cartItem = data[index];
                                return ProviderScope(overrides: [
                                  cartModelProvider.overrideWithValue(cartItem)
                                ], child: const CartListItem());
                              },
                            )
                          ],
                        ),
                      );
              },
              orElse: SizedBox.shrink);
        },
      ),
      bottomSheet: Consumer(
        builder: (_, WidgetRef ref, __) {
          final carNotEmpty = ref
              .watch(cartProvider)
              .maybeWhen(data: (data) => data.isNotEmpty, orElse: () => false);

          return CartCheckupButton(
              isEnabled: carNotEmpty, gotoCheckout: () => _gotoCheckup(ref));
        },
      ),
      bottomNavigationBar: NavigationTapBar(),
    );
  }

  void _gotoCheckup(WidgetRef ref) {
    ref.read(routerProvider).goNamed(RouteNames.cartCheckout);
  }
}
