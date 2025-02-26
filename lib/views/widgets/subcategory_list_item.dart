import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/controllers/providers/subcategory_item_provider.dart';

class SubcategoryListItem extends ConsumerStatefulWidget {
  const SubcategoryListItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubcategoryListItemState();
}

class _SubcategoryListItemState extends ConsumerState<SubcategoryListItem> {
  @override
  Widget build(BuildContext context) {
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
