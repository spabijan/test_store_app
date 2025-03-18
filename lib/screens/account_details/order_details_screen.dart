import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/account_details/providers/order_list_item_provider.dart';
import 'package:test_store_app/screens/account_details/widgets/order_list_tile_widget.dart';

import 'package:test_store_app/screens/category_screen/models/order_view_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    required this.viewModel,
    super.key,
  });

  final OrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          viewModel.productName,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        )),
        body: Column(children: [
          ProviderScope(
            overrides: [orderListItemProvider.overrideWithValue(viewModel)],
            child: const OrderListTileWidget(),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  width: 336,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffeff0f2))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Delivery address',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.7)),
                                  const SizedBox(height: 4),
                                  Text(
                                      '${viewModel.state} ${viewModel.city} ${viewModel.locality}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5)),
                                  const SizedBox(height: 4),
                                  Text('To ${viewModel.fullName}',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 4),
                                  Text('OrderID: ${viewModel.id}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.5))
                                ])),
                        viewModel.delivered
                            ? TextButton(
                                onPressed: () {},
                                child: Text('Leave a Review',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)))
                            : const SizedBox.shrink()
                      ])))
        ]));
  }
}
