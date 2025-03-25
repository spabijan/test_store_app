import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/provider/cart_provider.dart';
import 'package:test_store_app/screens/cart_screen/providers/cart_list_item_provider.dart';

class CartListItem extends ConsumerWidget {
  const CartListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItem = ref.watch(cartModelProvider);
    return Card(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    cartItem.image.first,
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartItem.productName,
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(cartItem.category,
                        style: GoogleFonts.lato(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    Text(' \$ ${cartItem.productPrice.toString()}',
                        style: GoogleFonts.lato(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff102de1)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _decrementItem(ref, cartItem),
                                  icon: const Icon(
                                    CupertinoIcons.minus,
                                    color: Colors.white,
                                  )),
                              Text(' \$ ${cartItem.orderQuantity.toString()}',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              IconButton(
                                  onPressed: () =>
                                      _incrementItem(ref, cartItem),
                                  icon: const Icon(
                                    CupertinoIcons.plus,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () => _deleteItem(ref, cartItem),
                            icon: Icon(
                              CupertinoIcons.delete,
                              color: Colors.grey.shade700,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _decrementItem(WidgetRef ref, CartModel cartItem) {
    {
      ref.read(cartProvider.notifier).decrementCartItem(cartItem.productId);
    }
  }

  void _incrementItem(WidgetRef ref, CartModel cartItem) {
    {
      ref.read(cartProvider.notifier).incrementCartItem(cartItem.productId);
    }
  }

  void _deleteItem(WidgetRef ref, CartModel cartItem) {
    {
      ref.read(cartProvider.notifier).removeCartItem(cartItem.productId);
    }
  }
}
