import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/models/vendor_model.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';

class VendorItemWidget extends ConsumerWidget {
  const VendorItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendor = ref.watch(productItemProvider) as VendorModel;

    return Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(24)),
            child: vendor.storeImageUrl.isNotEmpty
                ? Image.network(
                    vendor.storeImageUrl,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  )
                : CircleAvatar(
                    radius: 50,
                    child: Text(vendor.fullName.toUpperCase()[0],
                        style: GoogleFonts.montserrat(
                            fontSize: 30, fontWeight: FontWeight.bold))),
          ),
          Text(vendor.fullName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xff212121))),
          Text(vendor.storeDescription,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: const Color(0xff212121))),
        ]));
  }
}
