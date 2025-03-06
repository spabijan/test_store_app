import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/model/models/cart/provider/cart_total_amount.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/cart_screen/providers/cart_list_item_provider.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_items_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_list_item.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetIcons.cartb), fit: BoxFit.cover)),
            child: const CartInfoIcon(),
          )),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final cartData = ref.watch(cartProvider);
          return cartData.isEmpty
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
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartData.values.toList()[index];
                          return ProviderScope(overrides: [
                            cartModelProvider.overrideWithValue(cartItem)
                          ], child: const CartListItem());
                        },
                      )
                    ],
                  ),
                );
        },
      ),
      bottomSheet: const CartCheckoutButton(),
      bottomNavigationBar: NavigationTapBar(),
    );
  }
}

class CartCheckoutButton extends StatelessWidget {
  const CartCheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                    width: 416,
                    height: 89,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffc4c4c4))))),
            Align(
                alignment: const Alignment(-0.63, -0.26),
                child: Text('Subtotal',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffa1a1a1)))),
            Align(
              alignment: const Alignment(-0.19, -0.26),
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final totalPrice = ref.watch(cartTotalAmountProvider);
                  return Text('\$$totalPrice',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: totalPrice > Decimal.fromInt(0)
                              ? const Color(0xffff6464)
                              : Colors.grey));
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.83, -1),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 166,
                  height: 77,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: const Color(0xff1532e7),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Checkout ',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
