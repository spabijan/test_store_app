import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productItemProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail',
            style: GoogleFonts.quicksand(
                fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
