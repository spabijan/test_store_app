import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/providers/subcategory_item_provider.dart';

class SubcategoryListItem extends ConsumerWidget {
  const SubcategoryListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subcategory = ref.watch(subcategoryItemProvider);
    return Column(
      children: [
        Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(color: Colors.grey),
            child: Center(
                child: Image.network(subcategory.categoryImage,
                    fit: BoxFit.cover))),
        Center(child: Text(subcategory.subcategoryName))
      ],
    );
  }
}
