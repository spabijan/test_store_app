import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/account_details/providers/order_list_item_provider.dart';
import 'package:test_store_app/screens/category_screen/models/order_view_model.dart';

class OrderListTileWidget extends ConsumerWidget {
  const OrderListTileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderVM = ref.watch(orderListItemProvider);
    return Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
            width: 335,
            height: 153,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: SizedBox(
                width: double.infinity,
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                          width: 336,
                          height: 154,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xffeff0f2))),
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                                left: 13,
                                top: 9,
                                child: Container(
                                    width: 78,
                                    height: 78,
                                    clipBehavior: Clip.none,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffbcc5ff),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                              left: 10,
                                              top: 5,
                                              child: Image.network(
                                                  orderVM.image,
                                                  width: 58,
                                                  height: 67,
                                                  fit: BoxFit.cover))
                                        ]))),
                            Positioned(
                                left: 101,
                                top: 14,
                                child: SizedBox(
                                    width: 216,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                                orderVM
                                                                    .productName,
                                                                style: GoogleFonts.montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16))),
                                                        const SizedBox(
                                                            height: 4),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              orderVM.category,
                                                              style: GoogleFonts.montserrat(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade800,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              '\$${orderVM.productPrice}',
                                                              style: GoogleFonts.montserrat(
                                                                  color: const Color(
                                                                      0xff0b0c1e),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14)),
                                                        )
                                                      ])))
                                        ]))),
                            Positioned(
                                left: 13,
                                top: 113,
                                child: Container(
                                    width: 100,
                                    height: 25,
                                    clipBehavior: Clip.none,
                                    decoration: BoxDecoration(
                                        color: _getDeliveryColor(orderVM)),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                            left: 9,
                                            top: 2,
                                            child: Text(
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3),
                                                _getDeliveryStatus(orderVM)))
                                      ],
                                    )))
                          ]))),
                  Positioned(
                      top: 115,
                      left: 298,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          AssetIcons.delete,
                          width: 20,
                          height: 20,
                        ),
                      ))
                ]))));
  }

  Color _getDeliveryColor(OrderViewModel order) {
    if (order.delivered) {
      return const Color(0xff3c55ef);
    } else if (order.processing) {
      return Colors.purple;
    } else {
      return Colors.red;
    }
  }

  String _getDeliveryStatus(OrderViewModel order) {
    if (order.delivered) {
      return 'Delivered';
    } else if (order.processing) {
      return 'Processing';
    } else {
      return 'Cancelled';
    }
  }
}
