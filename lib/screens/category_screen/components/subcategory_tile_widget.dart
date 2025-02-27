import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';

class SubcategoryTileWidget extends ConsumerWidget {
  const SubcategoryTileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subcategory = ref.watch(subcategoryItemProvider);

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              subcategory.categoryImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            subcategory.subcategoryName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
